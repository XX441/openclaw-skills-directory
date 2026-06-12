---
name: tdd
description: Test-driven development with red-green-refactor loop. Build features or fix bugs using TDD — one test at a time, behavior first. Use when user says "tdd", "test-first", "red-green-refactor", wants integration tests, or asks for test-driven development on Phase 3 code.
adapted_from: mattpocock/skills (77.8k ⭐ GitHub)
---

# Test-Driven Development for IGSO Phase 3

## Philosophy

**Core principle**: Tests verify behavior through public interfaces, not implementation details. Code can change entirely; tests shouldn't.

**Good tests** are integration-style — they exercise real code paths through public APIs. They describe *what* the system does, not *how*. These survive refactors.

**Bad tests** mock internal collaborators, test private methods, or verify through external means. Warning sign: test breaks when you refactor but behavior hasn't changed.

## Required Discipline Before Code

Load `coding-discipline` first for any real code change. For Phase 3 code, also load the Phase 3 knowledge base before touching files:

1. `PROJECT_INDEX`
2. `① Schema Map`
3. `② API Map`
4. `③ Dependency Graph`
5. `④ Components`
6. `⑤ Change Impact Reference`

Before writing the first test, state:
- Which behavior is being tested through which public interface
- Which files may change, and what depends on them
- Which command proves RED, then GREEN
- Which routes/pages/API paths must be checked after the change

If any of that is unclear, stop and ask. Do not guess in Phase 3 code.

## Anti-Pattern: Horizontal Slices

**DO NOT** write all tests first, then all implementation. This produces tests that test *imagined* behavior, not *actual* behavior.

**Correct approach**: Vertical slices via tracer bullets:
```
WRONG: RED: test1, test2, test3 → GREEN: impl1, impl2, impl3
RIGHT: RED: test1→impl1 → RED: test2→impl2 → ...
```

## Workflow

### 1. Planning
Before writing any code, confirm with Leo:
- Interface changes needed
- Which behaviors to test (prioritize — can't test everything)
- Deep module opportunities (small interface, deep implementation)
- Boundaries where mocks are allowed (external APIs, time/randomness, filesystem, sometimes DB)

### 2. Tracer Bullet
```
RED:   Write one test → test fails for the expected reason
GREEN: Write minimal code to pass → passes
```

### 3. Incremental Loop
For each remaining behavior — one test at a time, minimal code each cycle. Keep assertions on public behavior, not internal call order.

### 4. Refactor
After tests pass, look for: duplication, long methods, shallow modules, feature envy, primitive obsession. Never refactor while RED.

## Interface Design Rules

- Accept dependencies; don't construct external clients deep inside business logic.
- Return results where practical; don't hide behavior behind unobservable side effects.
- Keep the test surface small: fewer methods, fewer params, clearer invariants.
- Mock only at system boundaries. Don't mock code we own just to make a test pass.
- Prefer test DB/fixtures for domain behavior when feasible; use mocks for true external services.

## Phase 3 Code Application

When working on XX441 repos:
- Start by understanding existing test infrastructure (if any)
- Identify critical paths: trust resolver, freshness cert, API endpoints
- Focus test effort on mission-critical behavior (anti-counterfeit logic)
- Consider running `zoom-out` first to map the codebase

## Done Criteria

After a TDD change, report:
1. Every file changed
2. Every test command run, including the RED failure and final GREEN result
3. Every page/API/route checked
4. Confirmation no adjacent code was touched beyond the approved scope
5. Whether Phase 3 docs/dependencies changed; if yes, update docs or flag it
