---
name: mattpocock-skills
description: Collection of agent skills adapted from Matt Pocock (77k ⭐ GitHub). Includes: grill-me, handoff, to-prd, caveman, diagnose, zoom-out, to-issues, write-a-skill, triage, tdd, improve-codebase-architecture, prototype, grill-with-docs. Use when Leo asks for: engineering discipline, code audit, TDD, architecture improvement, prototype, design stress-test.
---

# Matt Pocock Skills for OpenClaw

Adapted from [github.com/mattpocock/skills](https://github.com/mattpocock/skills) (77.8k ⭐). These skills work with OpenClaw, keeping the original spirit but adapted for Leo's agent context.

## Available Skills

| # | Skill | Use When | Phase 3 Fit |
|---|-------|----------|-------------|
| 1 | `grill-me` | Stress-test a plan or idea | Any strategy |
| 2 | `handoff` | Create a session handoff doc | Agent handoffs |
| 3 | `to-prd` | Turn conversation into a PRD | Feature specs |
| 4 | `caveman` | Simplify an explanation | Any |
| 5 | `diagnose` | Diagnose a problem or error | 🟢 Bug fixing |
| 6 | `zoom-out` | Step back and see bigger picture | 🟢 Code audit |
| 7 | `to-issues` | Turn a plan into actionable issues | Task breakdown |
| 8 | `write-a-skill` | Create or improve an agent skill | Skill creation |
| 9 | `triage` | Triage and prioritize incoming items | Inbox processing |
| 10 | **`tdd`** 🆕 | **Test-driven development** | 🟢 **Phase 3 quality** |
| 11 | **`improve-codebase-architecture`** 🆕 | **Find & fix shallow modules** | 🟢 **Phase 3 audit** |
| 12 | **`prototype`** 🆕 | **Throwaway code to explore designs** | 🟢 **Interface exploration** |
| 13 | **`grill-with-docs`** 🆕 | **Stress-test plan against domain model** | 🟢 **Spec validation** |

## Quick Reference

- **"grill me on this plan"** → Stress-test a strategy
- **"handoff this session"** → Create a handoff for another agent
- **"turn this into a PRD"** → Formalize discussion into requirements
- **"explain like I'm a caveman"** → Simplify complex concepts
- **"diagnose this issue"** → Systematic troubleshooting
- **"zoom out"** → See the bigger picture
- **"break this into issues"** → Create actionable task list
- **"tdd this feature"** → Test-driven development on Phase 3 code
- **"improve architecture"** → Find deepening opportunities
- **"prototype this"** → Build throwaway code to test a design
- **"grill with docs"** → Stress-test against domain model

## Phase 3 Workflow Recommendation

Run this only after Leo gives explicit go-ahead for Phase 3 code work.

1. Start with `zoom-out` on XX441 repos
2. Run `improve-codebase-architecture` to identify issues
3. Fix bugs with `diagnose`
4. Write new features with `tdd`
5. Explore interface designs with `prototype`
6. Validate specs with `grill-with-docs`
7. Document with `to-prd` → breakdown with `to-issues`

Before any code change, load `coding-discipline` and the Phase 3 knowledge base: PROJECT_INDEX → Schema Map → API Map → Dependency Graph → Components → Change Impact Reference. These skills are execution tools, not permission to refactor or edit code without approval.
