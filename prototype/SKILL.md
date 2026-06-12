---
name: prototype
description: Build a throwaway prototype to flesh out a design before committing to code. Explore trust interface designs, API surfaces, state models, or UI mockups quickly. Use when Leo says "prototype this", "try a few designs", "explore", "mock up", or for Phase 3 interface exploration.
adapted_from: mattpocock/skills (77.8k ⭐ GitHub)
---

# Prototype for IGSO Phase 3

A prototype is **throwaway code that answers a question**. It is not production code, not a shortcut around TDD, and not a place to quietly introduce architecture.

## Required Discipline

Before building a prototype, state:
- The exact question the prototype answers
- Where the prototype will live and how to run it
- What production files, if any, it may read
- The deletion/absorption plan

For Phase 3, load relevant docs first if the prototype touches domain concepts, interfaces, or repo structure. Do not let prototype assumptions override the Phase 3 SSOT.

## Pick a branch

- **Logic/state model question** → Build a tiny interactive terminal app pushing the state machine through cases hard to reason about on paper.
- **UI question** → Generate several different UI variations on a single route, switchable via query params and a floating bottom bar.

Default: backend code → logic branch; frontend code → UI branch. State your assumption.

## Rules

1. **Throwaway from day one.** Clearly marked as prototype. Located close to where it will be used or in an obvious scratch/prototype path.
2. **One command to run.** `go run`, `npx tsx`, `python`, etc.
3. **No persistence.** State in memory. If database needed, scratch DB with clear name.
4. **Skip polish.** No tests, no error handling beyond runnability, no abstractions.
5. **Surface the state.** Print or render full state after every action.
6. **No production coupling creep.** Prototype code must not become imported production code accidentally.
7. **Delete or absorb when done.** The answer is what matters — capture it in a note, ADR, PRD, or approved implementation task, then delete the prototype.

## Phase 3 Applications

- Trust resolver API surface exploration
- GS1 data mapping prototype
- Trace page UI variations (consumer experience)
- Freshness certificate logic model

## Handoff Output

When done, report:
- Question answered
- Command used to run it
- Key finding / recommended direction
- Files created
- Whether files were deleted, retained temporarily, or need Leo approval to absorb into production
