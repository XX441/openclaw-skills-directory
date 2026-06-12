---
name: ssot-knowledge-graph
description: SSOT Knowledge Graph — connects new Drive files to projects, status files, action trackers, connection briefs, content index, and memory pointers. Use for "knowledge graph", "connect the dots", "link ideas", "SSOT connection", "cross-reference", "update status", "update tracker", "content index", "connection brief", "intake processing", "file connection", "project connection", "memory pointer", or "where does this fit". Part of the ssot-* skill family.
---

# SSOT Knowledge Graph (ssot-knowledge-graph)

Part of the **ssot-* skill family**. Sibling: `ssot-steward` (file hygiene).

## What It Does

When a new source file enters Drive, ssot-knowledge-graph ensures it is connected to the rest of the system — not just stored in isolation.

Core motion:

> New file → classify → connect to projects/status/trackers/index/memory → log

**Important: The Knowledge Graph is now a proper system on Drive.**
The canonical definition lives at:
`Good Steward Legacy / 02_Platform_Knowledge / Knowledge_Graph /` (ID `1BfSvK7oTS0NDC0p6riBtP4Yz-xBhJa8Z`)

Core files:
- `KG_Master_SSOT_v1.0.md` — system definition, file map, operating rules
- `KG_Permanent_Workflow_v1.0.md` — step-by-step connection + Memory anchor workflow
- `KG_Connection_Registry_v1.0.md` — canonical log of every connection made
- `KG_Memory_Anchor_Index_v1.0.md` — master index: every SSOT → its Memory anchor
- `KG_Mini_Audit_Protocol_v1.0.md` — Mini's instructions for auditing
- `Systems_Master_Registry_v1.0.md` — canonical inventory of all systems (output)

**The Memory Anchor Rule:** Every SSOT file in Drive must have a corresponding Memory anchor in MEMORY.md or daily log. This is now mandatory per v1.0.

See [connection-layer.md](references/connection-layer.md) for the legacy design reference.

---

## Core Workflow

### Step 1: Classify the file

Determine what kind of file it is:

| File Type | Examples | Primary action |
|---|---|---|
| Source document | Conference PDF, policy brief, research report | Create connection brief + update trackers |
| Meeting note | CG briefing, partner call notes | Update project status + meeting log |
| Deck/proposal | Deck content, pitch PDF | Update pipeline status + action tracker |
| Configuration | Config SSOT, cron spec | Update config index + HEARTBEAT |
| Partner profile | Organization profile, contact card | Update partner network index + relevant pipelines |
| Media/coverage | Press clipping, social post | Update media archive + content assets |
| Evidence/event | Photo, agenda, program PDF | Update event evidence + deployment records |

### Step 2: Create or update a connection brief

For strategically meaningful files, create a derived brief in the same Drive folder. A brief contains:

1. **Source facts** — what the file is, where it came from
2. **Strategic interpretation** — why it matters
3. **Connected SSOT nodes** — links to projects, partners, BD lanes, standards, events
4. **Action implications** — what should happen next
5. **Evidence/claim warnings** — what must be verified before publishing externally

**Naming:** `<Topic>_Brief_v1.0.md` or `<Topic>_Connection_v1.0.md`

### Step 3: Update connected nodes

For every relevant connection found in Step 2, update:

| Node Type | File | Update |
|---|---|---|
| Project status | `00_PROJECT_STATUS.md` / `00_WUWM_PROJECT_STATUS.md` | Update milestone, stage, or key facts |
| Action tracker | `*_Action_Tracker_v*.md` | Add new actions or update status |
| Pipeline summary | `memory/business-pipeline.md` | Update if BD status changes |
| Content index | `memory/ssot-content-index.md` | Add cluster entry and cross-file connections |
| Active tracking | `HEARTBEAT.md` | Update if it changes active work |
| Durable memory | `MEMORY.md` | Promote only if strategy, operating rules, or permanent pointers change |
| Daily log | `memory/YYYY-MM-DD.md` | Log the connection activity |

### Step 4: Log the connection

Always log to today's daily note:
- What file was processed
- What connections were made
- What was updated
- What needs Leo's attention (if any)

---

## Connection Strength Rules

- **Connect** when a file affects decisions, execution, credibility, or future retrieval
- **Skip** when a file is routine, purely administrative, or only interesting in isolation
- Goal: fewer, stronger operational links — not Obsidian-style link clutter

---

## Intake Processing

When a new file arrives via Drive upload, WhatsApp share, or Leo/Mandy request:

1. **Place the file** in the correct Drive folder (use `ssot-steward` rules)
2. **Classify it** using the table in Step 1 above
3. **Run the connection workflow** (Steps 2-4)
4. **Notify Leo** only if a decision or action is needed

---

## Navigation

| When you need… | Read… |
|---|---|
| Full design definition of the connection layer | [connection-layer.md](references/connection-layer.md) |
| SSOT file hygiene, naming, versioning | `ssot-steward` skill |
| GKE glossary for consistent terminology | Drive `06_Guru_Council/03_Knowledge_Engine/GKE_Glossary_v1.0.md` |
| IGSO translations | `memory/igso-translations.md` |
