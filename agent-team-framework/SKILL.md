---
name: agent-team-framework
description: "Reusable framework for managing AI coding agent teams (4-agent model: Architect + Frontend + Backend + Auditor). Load when setting up a new coding project with multiple AI agents, or when auditing agent performance. Covers: agent roles, shared knowledge system, Hard Gate enforcement, deploy pipeline, quality metrics, and governance. Based on Phase 3B IGSO project experience."
---

# Agent Coding Team Framework v1.0

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

## 6. Quick Start

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
