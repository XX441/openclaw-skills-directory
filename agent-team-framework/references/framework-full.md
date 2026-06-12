# Agent Coding Team Framework v1.1

**Created:** 2026-06-12
**Updated:** 2026-06-12 (v1.1 — gap-filled from community skill comparison)
**Purpose:** Reusable framework for managing AI coding agent teams on any project
**Source:** Built from Phase 3B IGSO project experience + ClawHub community pattern analysis

---

## 1. Architecture — The 4-Agent Model

```text
                    ┌──────────────┐
                    │   Architect  │  Java — specs, standards, review, SSOT
                    │   (Human)    │  Does NOT fix code directly
                    └──────┬───────┘
           ┌───────────────┼───────────────┐
           │               │               │
    ┌──────▼──────┐ ┌─────▼──────┐ ┌──────▼──────┐
    │   Frontend  │ │  Backend   │ │   Auditor   │
    │     3F      │ │    3B      │ │  Sentinel   │
    │ React/TS    │ │ Go/Gin     │ │ Playwright  │
    └─────────────┘ └────────────┘ └─────────────┘
```

## 2. Shared Knowledge System

```text
memory/agent-shared/          ← Single source of truth for agents
  ├── README.md               ← Load order (agents read this at startup)
  ├── brand-rules.md          ← Locked wording, colors, forbidden phrases
  ├── ui-ux-standard.md       ← Visual foundation, CSS values, templates
  ├── hard-gate-protocol.md   ← G1-G5 gates, deploy verification
  ├── testing-strategy.md     ← 4-layer testing pyramid
  ├── deploy-procedure.md     ← How to deploy, verification steps
  ├── agent-governance.md     ← Enforcement, scorecard, audit rules
  ├── agent-scorecard.md      ← Bug/deploy ratio per agent
  └── quality-improvement-plan.md ← Current vs target, improvement roadmap

Rule: Java writes. Agents read. Drive is SSOT authority.
Local files are mirrors with Drive ID metadata.
```

## 3. Hard Gate System

### Gates
| Gate | What | Who | When |
|---|---|---|---|
| G1 | API integrity | 3B | Every build |
| G2 | Browser smoke tests | 3F | Every deploy |
| G3 | Language consistency | Sentinel | Every deploy |
| G4 | Error hygiene | Sentinel | Every deploy |
| G5 | UI standard compliance | Sentinel | Every deploy |

### Enforcement (3 layers)
```text
Layer 1: Pre-commit hooks (client-side, immediate feedback)
Layer 2: GitHub Actions (server-side, blocks push if fail)
Layer 3: Sentinel cron (30-min monitoring, catches regressions)
```

### Rule: No "done" without gate pass
Agents must report test results with every completion.

## 4. Deploy Pipeline

```text
Source:       GitHub (single source of truth)
Build:        Agent's local machine
Transfer:     COS relay (fast internal network)
Deploy:       /opt/deploy-staging.sh on CVM (4 seconds)
Verify:       curl + Hard Gate pass
Tag:          git tag staging-YYYYMMDD-HHMM
```

## 5. Quality Metrics

| Metric | Target | Alert | Measurement |
|---|---|---|---|
| Bug/deploy ratio | < 0.2 | > 0.3 for 3 deploys | agent-scorecard.md |
| Leo-found bugs | 0/week | > 2/week | agent-scorecard.md |
| Test pass rate | 100% | < 100% | GitHub Actions |
| Deploy success rate | 100% | < 100% | Deploy script + verify |
| Standards compliance | 100% | Any violation | Sentinel G5 |

## 6. Setting Up a New Project

### Step 1: Create repos
```bash
git init project-frontend-staging
git init project-backend-staging
```

### Step 2: Create agent-shared folder
```bash
mkdir -p memory/agent-shared/
# Copy framework templates, customize brand rules
```

### Step 3: Set up Hard Gate
```bash
# Frontend: .husky/pre-commit + .github/workflows/hard-gate.yml
# Backend: .husky/pre-commit + .github/workflows/hard-gate.yml
```

### Step 4: Set up Sentinel
```bash
# Create e2e/sentinel-hard-gate.spec.ts
# Create 30-min cron job
# Create visual baselines
```

### Step 5: Set up deploy pipeline
```bash
# COS bucket + deploy script on server
# git tag on each deploy
```

### Step 6: Start tracking
```bash
# Create agent-scorecard.md (empty)
# First entry: initial deploy
```

---

## 6. Task Lifecycle — Detailed

### State Machine

```text
                    ┌──────────┐
                    │  Inbox   │  New task created by Architect
                    └────┬─────┘
                         │ Architect triages → assigns to agent
                    ┌────▼─────┐
                    │ Assigned │  Agent acknowledged, not yet started
                    └────┬─────┘
                         │ Agent starts work + comments
                    ┌────▼──────┐
                    │ In Progress│ Agent actively working
                    └────┬──────┘
                         │
              ┌──────────┼──────────┐
              │                     │
         ┌────▼─────┐        ┌─────▼──────┐
         │  Review   │        │   Failed   │ Valid end state
         └────┬─────┘        └────────────┘
              │ Reviewer approves
         ┌────▼─────┐
         │   Done   │ Task complete, file → _done/
         └──────────┘
```

### Transition Rules

1. **Architect owns ALL state transitions** — frontmatter `Status:` field in every task file
2. **Agent cannot move from In Progress to Done** — must pass through Review
3. **Agent can self-transition**: Assigned → In Progress (with start comment)
4. **Agent can self-declare Failed** (with reason)
5. **Reviewer can transition**: Review → Done (approved) or Review → In Progress (revisions needed)
6. **Stale timer**: >24h in In Progress with no comment → Architect escalates

### Task File Frontmatter Template

```markdown
**From:** Java
**To:** 3F
**Status:** In Progress  ← Architect updates this
**Created:** 2026-06-12 10:00 HKT
**Last Activity:** 2026-06-12 11:30 HKT (3F: login page built, see commit a1b2c3d)
**Review Due By:** 2026-06-12 14:00 HKT
```

---

## 7. Handoff Protocol — Detailed

### The 5 Fields (mandatory)

```markdown
## Handoff from 3F → Sentinel

**What was done:** Built ForgotPassword page with dual-channel reset.
**Where artifacts are:** Repo XX441/igso-frontend, commit bd3c517. Staging at admin-staging.awwws.cn/forgot-password
**How to verify:** npx playwright test --grep "G2" --workers=1
**Known issues:** SMS channel waiting on Tencent approval. Rate limiting stub only.
**What's next:** Run G1-G5 sweep, check visual baselines.
```

### Bad Handoffs (do NOT do these)

```markdown
❌ "Done, check the files."
❌ "Fixed the bug. Deployed."
❌ "It works on my machine."
```

---

## 8. Role Flexibility — Detailed

### Scaling Decision Matrix

| Factor | 2-Agent | 3-Agent | 4-Agent | N-Agent |
|---|---|---|---|---|
| Project complexity | Low | Medium | High | Very high |
| Codebase size | < 5K lines | 5-50K lines | 50-200K lines | > 200K lines |
| Frontend + Backend | No | Maybe | Yes | Yes (multiple) |
| External integrations | 0-1 | 1-3 | 3-5 | 5+ |

### Adding/Removing Roles

Adding: Define boundaries → Create task queue → Add gates → Update scorecard → Brief team.
Removing: Reassign tasks → Archive role gates → Update governance doc.

---

## 9. Model Tiering — Detailed

### Cost Split (target)

```text
High Reasoning ($$):  Architect 10-20% + Reviewer 15-25% = 25-45% of tokens
Balanced ($):        Builder 40-60% of tokens (bulk work)
Lightweight (¢):     Auditor 5-15% of tokens (periodic, small prompts)
```

**Rule:** Never use a cheap model for review. Cost of missed bug >> cost of good reviewer.

---

## 10. Auditor / Ops — Detailed

### Cron Registry

| Job | Schedule | Agent | Silent? |
|---|---|---|---|
| Health check | 30 min | Sentinel | Yes (alert on fail) |
| Hard Gate sweep | 30 min | Sentinel | Yes |
| Standup summary | Daily 09:00 | Sentinel | No |
| Weekly metrics | Mon 09:00 | Sentinel | No |

### Escalation

| Event | Action |
|---|---|
| Endpoint down | Immediate alert to Architect |
| 3+ gate failures | Block all deploys |
| Agent silent >4h | Ping, then escalate |
| Scorecard breached | Flag for retraining |

---

## 11. Common Pitfalls — Detailed

1. **No artifact paths** → Agent completes but you can't find output. Fix: always specify path + repo + branch.
2. **Skipping review** → 3-5 small deploys compound into defects. Fix: every artifact gets non-author review.
3. **Silent agents** → >2h no comment = assume stuck. Fix: mandatory comments at start/blocker/handoff/done.
4. **Capability mismatch** → Assigning browser test to agent without Playwright. Fix: maintain capability matrix.
5. **Architect execution creep** → Architect starts coding → loses oversight. Fix: spawn temp Builder instead.

---

## 12. When NOT to Use

| Scenario | Use Instead |
|---|---|
| Single-agent | AGENTS.md + SOUL.md |
| One-off task | sessions_spawn directly |
| Question routing | Forward directly (message) |
| Rapid prototyping | prototype skill |
| Trivial bug fix | One agent, one spawn |

---

## 13. Setting Up a New Project

## 14. Version History

### v1.1 — 2026-06-12
- Added Task Lifecycle state machine (Section 6)
- Added Structured Handoff Protocol with 5-field format (Section 7)
- Added Role Flexibility — 2 to N agent scaling (Section 8)
- Added Model Tiering per Role with cost optimization (Section 9)
- Added Auditor/Ops detailed role with cron registry (Section 10)
- Added Common Pitfalls — 5 documented gotchas (Section 11)
- Added When NOT to Use guardrail (Section 12)
- Gap-filled from ClawHub agent-team-orchestration community skill comparison

### v1.0 — 2026-06-12
- Initial framework from Phase 3B IGSO project
- 4-agent model, shared knowledge, Hard Gate, deploy pipeline, quality metrics
- Reusable template for any future coding project
