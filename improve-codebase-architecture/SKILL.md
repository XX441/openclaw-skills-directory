---
name: improve-codebase-architecture
description: Find deepening opportunities in Phase 3 IGSO codebase. Surface shallow modules, tight coupling, and untestable code. Propose refactors that make the code more testable and AI-navigable. Use when auditing Phase 3 code, planning refactors, or Leo asks "improve architecture", "refactor", "audit the codebase".
adapted_from: mattpocock/skills (77.8k ⭐ GitHub)
---

# Improve Codebase Architecture — IGSO Phase 3 Edition

Surface architectural friction and propose **deepening opportunities** — refactors that turn shallow modules into deep ones. Aim: testability, locality, and AI-navigability.

## Required Discipline

This skill is for analysis first, implementation second.

Before editing any code:
- Load `coding-discipline`
- Load the Phase 3 knowledge base: PROJECT_INDEX → Schema Map → API Map → Dependency Graph → Components → Change Impact Reference
- Produce candidate refactors with explicit files, affected dependencies, and verification gates
- Get Leo's approval before implementing any refactor

Do not improve adjacent code opportunistically. Do not refactor settled architecture without evidence from code + docs.

## Glossary (use exactly these terms)

- **Module** — anything with an interface and implementation (function, class, package, slice)
- **Interface** — everything a caller must know: types, invariants, error modes, ordering, config (not just type signature)
- **Depth** — leverage at the interface: lots of behavior behind a small interface. **Deep** = good. **Shallow** = bad.
- **Seam** — where an interface lives; a place behavior can be altered without editing in place
- **Adapter** — concrete thing satisfying an interface at a seam
- **Leverage** — what callers get from depth
- **Locality** — change, bugs, knowledge concentrated in one place

**Key principles:**
- Deletion test: if a module is deleted, does complexity vanish (pass-through) or reappear across N callers (earning its keep)?
- The interface is the test surface
- One adapter = hypothetical seam. Two adapters = real seam
- Deep modules hide complexity; shallow modules export complexity

## Process

### 1. Explore (on XX441 repos)
Walk the codebase organically. Note friction:
- Where does understanding one concept require bouncing between many small modules?
- Where are modules shallow (interface as complex as implementation)?
- Where are pure functions extracted just for testability, but real bugs hide in how they're called?
- Where do tightly-coupled modules leak across seams?
- Which parts are untested or hard to test through current interface?
- Which interfaces force callers to know domain details that should be local?

### 2. Present candidates
For each opportunity, list:
- **Files** — which files/modules involved
- **Current interface** — what callers must know today
- **Problem** — why current architecture causes friction
- **Proposed deeper module** — plain English what would change
- **Benefits** — locality, leverage, test improvements
- **Risk / blast radius** — dependencies from Phase 3 docs and code search
- **Verification** — tests/routes/pages/API checks that prove behavior is unchanged

### 3. Proceed with refactor
Once Leo approves candidates, implement with TDD discipline:
1. Add/confirm behavior tests through public interface
2. Refactor surgically
3. Run verification gates
4. Update Phase 3 docs only if dependencies/interfaces actually changed

## Refactor Candidate Heuristics

Look for:
- Pass-through wrappers
- Repeated validation / mapping logic across callers
- Long methods hiding multiple concepts
- Primitive obsession around IDs, cert states, freshness status, GS1 identifiers
- Feature envy: logic living away from the data/domain concept it depends on
- Interfaces that require caller-side sequencing or hidden ordering knowledge
- Tests that must mock many internal modules to reach one behavior

## Phase 3 Priority Areas

- Trust resolver logic (anti-counterfeit engine)
- API layer / middleware composition
- Data standardization modules (GS1 alignment)
- Frontend trace page (igso-frontend)
- Freshness certificate status and lifecycle logic

## Done Criteria

For an architecture audit, deliver candidates only unless approved to edit. For an implemented refactor, report changed files, tests/routes checked, and confirmation that no adjacent code was touched.
