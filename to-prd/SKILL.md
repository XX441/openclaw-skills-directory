---
name: to-prd
description: Turn the current conversation context into a Product Requirements Document (PRD). Synthesize what was discussed into structured requirements. Use when user wants to create a PRD, document requirements, or mentions "PRD", "requirements doc", "spec this out".
adapted_from: mattpocock/skills (77.8k ⭐ GitHub)
---

Turn the current conversation context into a PRD. Do NOT interview the user — just synthesize what you already know.

## Process

1. Review the conversation to understand the full context.
2. Extract: problem statement, proposed solution, user stories, implementation decisions.
3. Write the PRD in markdown.
4. Save to Drive under the appropriate project lane (01-04) based on content type.
5. Report the Drive link.

## PRD Template

```
# [Feature/Project Name] PRD v1.0

## Problem Statement
The problem from the user's perspective.

## Solution
The proposed solution, from the user's perspective.

## User Stories
Numbered list in format: As a <actor>, I want <feature>, so that <benefit>.

## Implementation Decisions
Key technical and strategic decisions made.

## Success Criteria
How we'll know this is done.

## Risks & Mitigations
What could go wrong, and how we'll handle it.

## Timeline & Dependencies
What's needed, in what order, by when.
```
