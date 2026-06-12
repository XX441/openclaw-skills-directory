---
name: coding-discipline
description: "Enforces Karpathy-style coding discipline for ALL code changes. Always-on rule — triggers on any coding, code change, refactor, bug fix, deploy, rebrand, website edit, or feature addition. Load BEFORE modifying any file. Based on Andrej Karpathy's CLAUDE.md — 4 rules that took AI coding accuracy from 65% to 94%."
---

# Coding Discipline — IGSO Phase 3 Code

Based on Andrej Karpathy's CLAUDE.md. 4 rules. 65 lines. 65% → 94% accuracy.

Tradeoff: caution over speed. For trivial one-line edits, use judgment.

---

## 1. Think Before Coding

Before touching any file:

- **Load Phase 3 docs from Drive** — `02_Platform_Knowledge/Awwws Platform/02_Technology_Architecture/`
  - Start with `Phase3_Change_Impact_Reference_v1.0.md` — find your file, read what breaks
  - Check `Phase3_Dependency_Graph_v1.0.md` — trace the dependency chain
- **State assumptions explicitly.** If uncertain, stop and ask.
- If multiple approaches exist, present them — don't pick silently.
- If something is unclear, name what's confusing. Ask.

## 2. Simplicity First — Minimum Code

- No features beyond what was explicitly requested.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't asked for.
- No error handling for impossible scenarios.
- If 200 lines could be 50, rewrite it.
- Ask: "Would a senior engineer say this is overcomplicated?"

## 3. Surgical Changes — Touch Only What You Must

When editing existing code:

- **Don't "improve" adjacent code, comments, or formatting.**
- **Don't refactor things that aren't broken.**
- **Match existing code style exactly** — even if you'd do it differently.
- **Every changed line must trace directly to the user's request.**
- If you notice unrelated dead code, mention it — don't delete it.
- Remove only imports/variables/functions YOUR changes made unused.

## 4. Goal-Driven Execution — Verify Before "Done"

Transform tasks into verifiable goals:

| Vague | → | Verifiable |
|-------|---|------------|
| "Fix the bug" | → | "Write a test that reproduces it, then make it pass" |
| "Refactor X" | → | "Ensure all affected pages load before and after" |
| "Add feature" | → | "State which 3 pages to test, test each, report results" |

For multi-step: state plan with verify check per step:
```
1. [Step] → verify: [check]
2. [Step] → verify: [check]  
3. [Step] → verify: [check]
```

## 5. Post-Change Discipline

After every code change:
1. List every file changed
2. List every page/API/route tested
3. Confirm no adjacent code was touched
4. Update Phase 3 docs if dependencies shifted

## Pre-Change Checklist

Before ANY code change, answer:
1. Which file am I changing? → Find it in Change Impact Reference
2. What depends on it? → Read the dependency chain
3. What pages must I test after? → List them
4. Is this a ⚠️ Phase 3 unresolved item? → Check missing tables, broken routes

## General Quick Reference

| Resource | Location |
|----------|----------|
| **Phase 3 Code (IGSO platform)** | `~/projects/igso/` · GitHub XX441/igso-frontend, XX441/igso-backend · Drive `02_Platform_Knowledge/Awwws Platform/02_Technology_Architecture/` |
| **Awwws Website** | GitHub XX441/awwws-world-website · Vercel |
| **IGSO Website** | GitHub XX441/igsoworld · igsoworld.org |
| **Ecosystem Platform** | GitHub XX441/IGSO-Ecosystem-Platform |

For Phase 3 code specifically, load the 5 knowledge base docs first: PROJECT_INDEX → ① Schema Map → ② API Map → ③ Deps → ④ Components → ⑤ Impact Ref.
