---
name: to-issues
description: Break down a plan, PRD, or discussion into actionable, prioritized issue tickets. Each issue should be independently completable. Use when user says "create issues", "break this down", "task list", "make tickets", or wants to turn a plan into executable work items.
adapted_from: mattpocock/skills (77.8k ⭐ GitHub)
---

Break down the current plan or discussion into actionable issues.

## Process

1. Review the full context of what needs to be done.
2. Break into discrete, independently completable tasks.
3. Prioritize by dependency order (blockers first).
4. Each item should be: specific enough to execute, small enough to complete in one session.
5. Save as `memory/issues/<project-name>.md`.

## Issue Format

```markdown
## [ ] Issue Title

**Priority:** P0 (blocking) / P1 (this week) / P2 (next) / P3 (someday)
**Depends on:** (none / issue #X)
**Estimated effort:** S (30min) / M (2hr) / L (1 day)

### What
Clear description of what needs to be done.

### Done when
Specific, verifiable completion criteria.

### Notes
Context, references, constraints.
```
