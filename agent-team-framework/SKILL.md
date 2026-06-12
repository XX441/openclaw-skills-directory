---
name: agent-team-framework
description: "Reusable framework for managing AI coding agent teams (4-agent model: Architect + Frontend + Backend + Auditor). Load when setting up a new coding project with multiple AI agents, or when auditing agent performance. Covers: agent roles, shared knowledge system, Hard Gate enforcement, deploy pipeline, quality metrics, and governance. Based on Phase 3B IGSO project experience."
---

# Agent Coding Team Framework v1.1

Reusable for any coding project. Built from Phase 3B IGSO production use.

Tradeoff: discipline over speed. For one-shot simple tasks, use judgment. For any multi-agent project, follow this framework.

---

## 1. Load Order

When setting up a new coding project with agents:

1. Read this SKILL.md (architecture + rules)
2. Read `references/framework-full.md` (detailed implementation)
3. Create `memory/agent-shared/` folder with customized templates
4. Set up Hard Gate (pre-commit + GitHub Actions + Sentinel)
5. Set up deploy pipeline
6. Start agent scorecard

---

## 2. The 4-Agent Model

```text
Architect (Human) — specs, standards, review, SSOT
  ├── Frontend Agent  — React/TS, UI implementation
  ├── Backend Agent   — Go/Python, API implementation
  └── Auditor Agent   — Testing, monitoring, visual regression
```

### Rules:
- Architect NEVER fixes code directly. Only reviews, specs, delegates.
- Frontend/Backend NEVER report "done" without Hard Gate pass evidence.
- Auditor runs on cron, silent if pass, escalates if fail.

---

## 3. Shared Knowledge System

```text
memory/agent-shared/
  ├── README.md          ← Load order (agents read at startup)
  ├── brand-rules.md     ← Colors, wording, locale codes
  ├── ui-ux-standard.md  ← Visual foundation, CSS values
  ├── hard-gate-protocol.md ← G1-G5 gates, deploy verification
  ├── testing-strategy.md   ← Testing pyramid
  ├── deploy-procedure.md   ← How to deploy
  ├── agent-governance.md   ← Enforcement + scorecard rules
  └── agent-scorecard.md    ← Bug/deploy per agent
```

**Rule:** Architect writes. Agents read at startup. Drive is SSOT authority.

---

## 4. Hard Gate Enforcement (3 Layers)

| Layer | Mechanism | Bypassable? |
|---|---|---|
| Pre-commit hooks | `.husky/pre-commit` | Yes (`--no-verify`) |
| GitHub Actions | `.github/workflows/hard-gate.yml` | No |
| Sentinel cron | 30-min monitoring | N/A |

**Rule:** Any gate failure = deploy REJECTED. Agent must fix before pushing.

---

## 5. Quality Metrics

| Metric | Target | Alert |
|---|---|---|
| Bug/deploy ratio | < 0.2 | > 0.3 × 3 deploys → retrain |
| Leo-found bugs | 0/week | > 2/week → investigate |
| Test pass rate | 100% | < 100% → block deploy |

---

## 6. Task Lifecycle

Every task moves through a defined state machine. The Architect owns state transitions.

```text
Inbox → Assigned → In Progress → Review → Done
                              ↘ Failed (valid end state)
```

### Rules:
- Architect owns ALL state transitions — never rely on agents to update their own status
- Every transition gets a comment (who, what, why) in the task file
- Failed is a valid end state — capture why, learn, move on
- Stale tasks (>24h no comment) → escalate to Architect

### Task file naming:
```text
memory/tasks/java_to_3f_<description>.md  ← Architect → Frontend
memory/tasks/java_to_3b_<description>.md  ← Architect → Backend
memory/tasks/java_to_sentinel_<description>.md  ← Architect → Auditor
```

---

## 7. Structured Handoff Protocol

When work passes between agents, the handoff MUST include all 5 fields:

| Field | Content |
|---|---|
| **What was done** | Summary of changes/output produced |
| **Where artifacts are** | Exact file paths, commit hashes, Drive IDs |
| **How to verify** | Test commands, acceptance criteria, expected behavior |
| **Known issues** | Anything incomplete, risky, or untested |
| **What's next** | Clear next action for the receiving agent |

### Example — Good handoff:
```markdown
**What was done:** Built auth module — login, register, forgot password, reset password.
**Where:** /src/pages/Login/, commit a1b2c3d. Staging: admin-staging.awwws.cn
**How to verify:** npx playwright test --grep "G2: auth flow" --workers=1
**Known issues:** Rate limiting not implemented. OAuth stubs in place but not wired.
**Next:** Reviewer checks error handling edge cases (empty fields, invalid tokens, expired links).
```

### Anti-pattern (bad handoff):
> "Done, check the files."

---

## 8. Role Flexibility — 2 to N Agents

The 4-agent model is a template, not a straitjacket. Scale up or down based on project needs:

| Team Size | Roles | When to Use |
|---|---|---|
| **2-agent** | Architect + Builder | Solo project, early prototype |
| **3-agent** | Architect + Builder + Reviewer | Small project, quality matters |
| **4-agent** | Architect + Frontend + Backend + Auditor | Full-stack production (Phase 3B default) |
| **N-agent** | Architect + specialists | Large project, multiple domains |

### Core principle: Every agent has ONE primary role. Overlap causes confusion.

### Role responsibilities:

| Role | Does | Does NOT |
|---|---|---|
| **Architect** | Specs, standards, review, SSOT, routing, state transitions | Fixes code, executes tasks |
| **Builder** | Produce artifacts — code, docs, configs | Decide architecture, change specs without review |
| **Reviewer** | Verify quality, push back on gaps, cross-check specs | Build new features, change scope |
| **Auditor/Ops** | Cron jobs, monitoring, health checks, visual regression | Build features, review code logic |

---

## 9. Model Tiering per Role

Match model capability to role complexity — optimizes cost without sacrificing quality:

| Role | Model Tier | Reasoning | Examples |
|---|---|---|---|
| **Architect** | High reasoning | Judgment, prioritization, complex decisions | deepseek-v4-pro, gpt-5.5, claude-opus-4.5 |
| **Builder** | Balanced | Mechanical execution, code generation | deepseek-v4-flash, gpt-5, claude-sonnet-4.5 |
| **Reviewer** | High reasoning | Catches what builders miss, edge case analysis | deepseek-v4-pro, gpt-5.5, claude-opus-4.5 |
| **Auditor/Ops** | Lightweight | Cron, health checks, simple assertions | deepseek-v4-flash, claude-haiku-4.5 |

### Rule: Reviewers and Architects need the same model tier. Both make judgment calls. If a reviewer misses a bug, it ships.

---

## 10. Ops/Cron Role

The Auditor role extends to Ops duties. Ops agents run on cron and stay silent unless something fails.

### Ops responsibilities:
- **Health checks** — Verify staging/production endpoints every 30 min
- **Cron monitoring** — Check all cron jobs completed, alert on failures
- **Scorecard updates** — Tally bug/deploy metrics weekly
- **Standup summaries** — Aggregate agent completions into daily report
- **Visual baselines** — Update Playwright screenshot baselines after approved changes

### Rule: Ops NEVER fixes — only reports. Fixing is the Builder's job.

---

## 11. Common Pitfalls

### 1. Spawning without clear artifact output paths
Agent produces great work, but you can't find it. Always specify exact output path in the task.

### 2. Skipping review = compounding errors
"It's a small change, skip review." Do this 3 times and you have compounding errors. Every artifact gets at least one set of eyes that didn't produce it.

### 3. Silent agents create blind spots
Require comments at: start, blocker, handoff, completion. If an agent goes silent >2h on an active task, assume it's stuck. Escalate.

### 4. Not verifying agent capabilities before assigning
Assigning browser testing to an agent without Playwright access. Check capabilities before routing.

### 5. Architect doing execution work
The Architect routes and tracks — it doesn't build. The moment you start "just quickly doing this one thing," you've lost oversight of the rest of the team. If the Architect must code, spawn a temporary Builder agent.

---

## 12. When NOT to Use This Framework

| Scenario | Use Instead |
|---|---|
| **Single-agent setup** | Standard AGENTS.md + SOUL.md conventions. Team framework adds overhead solo agents don't need. |
| **One-off task delegation** | `sessions_spawn` directly. This framework is for sustained workflows with multiple handoffs. |
| **Simple question routing** | Forward the question directly. That's a message, not a workflow. |
| **Rapid prototyping** | Use the `prototype` skill. Gate overhead slows exploration. |
| **Trivial bug fixes** | One agent, one spawn, one review. Full framework is overkill. |

---

## 13. Quick Start

```bash
# 1. Create shared folder
mkdir -p memory/agent-shared/

# 2. Create pre-commit hook (frontend)
cat > .husky/pre-commit << 'EOF'
#!/bin/sh
npx playwright test --grep "G2:" --workers=1 || exit 1
EOF

# 3. Create GitHub Actions
mkdir -p .github/workflows/
# Copy hard-gate.yml template

# 4. Start scorecard
echo "| Date | Agent | Deploys | Bugs | Bug/Deploy |" > memory/agent-shared/agent-scorecard.md

# 5. Go
```
