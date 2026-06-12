---
name: triage
description: Triage incoming items (WhatsApp messages, Drive files, emails, ideas) into prioritized action buckets. Categorize by urgency and type, applying project-specific labels and routing rules. Use when user says "triage", "sort this", "what should I focus on", or when processing a batch of new items.
adapted_from: mattpocock/skills (77.8k ⭐ GitHub)
---

Triage incoming items into prioritized action buckets.

## Process

1. List all incoming items in the current context.
2. For each item, classify by:
   - **Urgency** — P0 (today), P1 (this week), P2 (this month), P3 (someday), 🗑️ (skip)
   - **Type** — Action needed, FYI only, Needs response, Delegate
   - **Project** — Which pipeline/project does this belong to?
3. Apply project-specific routing (BD pipeline, IGSO standards, operations, etc.)

## Buckets

| Bucket | Action |
|--------|--------|
| 🔴 P0 — Today | Must do now or today. Drop everything else. |
| 🟡 P1 — This Week | Important, needs action soon. |
| 🟢 P2 — This Month | Worth doing, not urgent. |
| 🔵 P3 — Someday | Good idea, no timeline. |
| ⚪ FYI | Read and file, no action needed. |
| 🗑️ Skip | Not worth attention right now. |

## Output

Present the triaged list, then ask: "Does this priority order look right to you?"
