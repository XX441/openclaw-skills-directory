---
name: grill-with-docs
description: Stress-test a plan or interface design against the IGSO domain model. Sharpens terminology, validates assumptions, and updates documentation (CONTEXT.md, ADRs) inline. Use when designing new interfaces, writing specs, or need to make sure a plan matches IGSO's business language.
adapted_from: mattpocock/skills (77.8k ⭐ GitHub)
---

# Grill With Docs — IGSO Domain Stress Test

Interview relentlessly about every aspect of a plan until reaching shared understanding. Walk down each branch of the design tree, resolving dependencies one-by-one. Ask questions one at a time, waiting for feedback before continuing.

## Required Discipline

Use docs as SSOT, not vibes. For Phase 3 work, check the relevant knowledge base before challenging or changing terminology:

1. PROJECT_INDEX
2. Schema Map
3. API Map
4. Dependency Graph
5. Components
6. Change Impact Reference
7. Existing `CONTEXT.md`, `CONTEXT-MAP.md`, and `docs/adr/` in the repo, if present

Do not update docs casually. If documentation changes are needed, keep them narrow, cite the decision, and avoid re-litigating settled ADRs.

## Domain Awareness

When exploring code, look for:
- `CONTEXT.md` / `CONTEXT-MAP.md` at repo root
- `docs/adr/` for past architectural decisions
- Existing glossary / canonical terms
- Phase 3 platform docs and Drive SSOT if the repo docs are incomplete

Create files lazily — only when there's something durable to write.

## During the session

- **Challenge against glossary** — if a term conflicts with existing language, call it out
- **Sharpen fuzzy language** — propose precise canonical terms for vague/overloaded ones
- **Discuss concrete scenarios** — stress-test relationships with edge cases
- **Cross-reference with code** — if the user says how something works, check whether the code agrees
- **Ask one question at a time** — avoid dumping a questionnaire
- **Update docs inline only after agreement** — resolve terms as they happen, don't batch speculative changes
- **Offer ADRs sparingly** — only when all three are true: hard to reverse, surprising without context, result of real trade-off

## Phase 3 Applications

- Trust interface layer API design
- GS1 data model alignment
- Freshness certification logic
- Resolver spec validation

## Output Format

For a completed grill session, return:
- Decisions locked
- Terms clarified / canonical wording
- Open questions
- Docs changed, if any
- Recommended next skill (`prototype`, `tdd`, `to-prd`, or `to-issues`)
