---
name: handoff
description: Compact the current conversation into a handoff document for another agent or session to continue the work. Use when user wants to hand off work, create a session summary for another agent, or mentions "handoff", "pass this to", "continue this in another session".
adapted_from: mattpocock/skills (77.8k ⭐ GitHub)
---

Write a handoff document summarising the current conversation so a fresh agent can continue the work.

## Process

1. Summarize what was done, key decisions made, and current state.
2. List what remains to be done, with clear next actions.
3. Note any blockers, open questions, or decisions pending.
4. Reference Drive files, PRDs, or other artifacts by path (don't duplicate them).
5. Suggest which skills the next session should use.

Save the handoff to `memory/handoffs/YYYY-MM-DD_HHMM.md` so it can be loaded by the next session.

If the user specifies what the next session will focus on, tailor the doc accordingly.
