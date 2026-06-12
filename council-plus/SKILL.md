---
name: council-plus
description: Run the full Guru Council workflow end-to-end: triage topic → zoom out → summon guru council → stress-test synthesis → package as PRD + issues → handoff. Use when user says "Guru Council on [topic]", "guru council", "full council workflow", or wants a topic run through the complete council pipeline.
rules:
  - do-not-read(this)
  - on-load(grill-me)
  - on-load(zoom-out)
  - on-load(to-prd)
  - on-load(to-issues)
  - on-load(handoff)
  - on-load(triage)
---

# Guru Council — Complete Workflow

A single command that runs the full guru council pipeline from triage to handoff.

## Trigger

**"Guru Council 🌾 IGSO on [topic]"** or **"Guru Council on [topic]"**

## Flow

### Phase 0: Triage + Frame (1-2 min)
- `triage` the topic — is this right for a council? Which council? What priority?
- `zoom-out` — map strategic context, identify what the council needs to answer
- **Verify understanding with Leo before proceeding**

### Phase 1: Summon Council
- Standard 4 rounds: individual pitches → cross-challenge → rebuttal → Java synthesis
- Load GKE from Drive `06_Guru_Council/03_Knowledge_Engine/` first
- Councils: 💰 Finance / 📊 Business / 🌾 IGSO / ⚖️ Legal / 🛍️ Frutodor / 🔧 Awwws / 👴 Frutus

### Phase 2: Stress-Test Synthesis ⭐
- `grill-me` the council's output before presenting to Leo
- Find weak points, unresolved conflicts, missing perspectives
- Surface decisions that need Leo's judgment
- Don't just deliver — strengthen

### Phase 3: Package
- `to-prd` — turn findings into a structured doc on Drive
- `to-issues` — break into executable tasks with P0-P3 priority
- `handoff` — compact for Leo with: what we learned, what's decided, what's next

## One-Line Usage

```
"Guru Council 🌾 IGSO on MNSV pilot design"
"Guru Council 📊 Business on Thailand Durian GTM"
"Guru Council ⚖️ Legal on MOU v4 review"
```

## Output

After the full workflow, Leo receives:
1. 🔴 **Grilled synthesis** — stress-tested findings with weak points flagged
2. 📄 **PRD** saved to Drive under the correct project lane
3. 📋 **Issue cards** with P0-P3 priority, ready to execute
4. 📝 **Handoff doc** — compact summary of everything
