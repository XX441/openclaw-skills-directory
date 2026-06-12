# Agent Coding Team Framework v1.0

**Created:** 2026-06-12
**Purpose:** Reusable framework for managing AI coding agent teams on any project
**Source:** Built from Phase 3B IGSO project experience

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

## 7. Version History

### v1.0 — 2026-06-12
- Initial framework from Phase 3B IGSO project
- 4-agent model, shared knowledge, Hard Gate, deploy pipeline, quality metrics
- Reusable template for any future coding project
