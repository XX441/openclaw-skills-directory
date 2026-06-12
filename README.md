# OpenClaw Skills Hub

**Custom skills for OpenClaw — reusable, composable, open source**

A browsable catalog of custom OpenClaw skills from Leo's workspace. Each skill is packaged as a folder containing a `SKILL.md` plus any supporting references, scripts, data files, or templates needed to use it.

## Skills Catalog

| Skill | Folder | Category | Description |
|---|---|---|---|
| 🤖 [agent-team-framework](./agent-team-framework/) | `agent-team-framework` | System | Reusable framework for managing multi-agent coding teams with clear roles, shared knowledge, quality gates, deployment flow, and governance. |
| 📊 [ai-ppt-generator](./ai-ppt-generator/) | `ai-ppt-generator` | Design | Generate branded presentation decks from structured prompts, brand assets, and slide assembly scripts. |
| 🎨 [canva](./canva-connect/) | `canva-connect` | Design | Manage Canva designs, assets, exports, and folders through the Canva Connect API. |
| 🪨 [caveman](./caveman/) | `caveman` | Communication | Simplify complex concepts into clear, accessible explanations for non-technical audiences. |
| 🧑‍💻 [coding-discipline](./coding-discipline/) | `coding-discipline` | Coding | Applies disciplined coding rules before, during, and after code changes: think first, keep changes surgical, verify before done. |
| 📝 [content-strategy](./content-strategy/) | `content-strategy` | Business | Build content strategy, pillars, calendars, distribution plans, repurposing workflows, and performance metrics. |
| 🧠 [council-plus](./council-plus/) | `council-plus` | Strategy | Runs a full Guru Council workflow from framing to council synthesis, stress-testing, PRD, issues, and handoff. |
| 🩺 [diagnose](./diagnose/) | `diagnose` | System | Structured troubleshooting process for identifying root causes behind errors, failures, or unexpected behavior. |
| ⚡ [frontend-performance](./frontend-performance/) | `frontend-performance` | Coding | Analyze and improve frontend performance across Core Web Vitals, loading, bundle size, stability, and runtime efficiency. |
| 🔥 [grill-me](./grill-me/) | `grill-me` | Strategy | Relentlessly interviews and stress-tests plans, strategies, or designs until assumptions and dependencies are clear. |
| 📚 [grill-with-docs](./grill-with-docs/) | `grill-with-docs` | Strategy | Stress-tests plans or interface designs against domain documentation and updates docs inline. |
| 🤝 [handoff](./handoff/) | `handoff` | Workflow | Compacts current work into a clear handoff document for another agent or future session. |
| 🏗️ [improve-codebase-architecture](./improve-codebase-architecture/) | `improve-codebase-architecture` | Coding | Finds architecture deepening opportunities: shallow modules, tight coupling, untestable code, and AI-navigation issues. |
| 🔎 [keyword-research](./keyword-research/) | `keyword-research` | Marketing | SEO keyword research and topic discovery with intent classification, clustering, prioritization, and report templates. |
| 💼 [linkedin-cli](./linkedin-cli/) | `linkedin-cli` | Business | CLI utilities for LinkedIn profile search, feed summaries, message checks, and session-based workflows. |
| 🛠️ [mattpocock-skills](./mattpocock-skills/) | `mattpocock-skills` | Workflow | Collection index of reusable engineering and thinking skills adapted from Matt Pocock-style agent workflows. |
| 🕸️ [ontology](./ontology/) | `ontology` | System | Typed knowledge graph pattern for structured memory, entities, relationships, constraints, and cross-skill state. |
| 🧪 [prototype](./prototype/) | `prototype` | Design | Build throwaway prototypes to explore interfaces, APIs, state models, or product ideas before committing to production code. |
| ⚛️ [react-expert](./react-expert/) | `react-expert` | Coding | React 18+ / 19 guidance for component architecture, hooks, state, Server Components, Suspense, performance, and testing. |
| 🌱 [self-improvement](./self-improving-agent/) | `self-improving-agent` | System | Captures mistakes, corrections, failures, feature requests, and reusable lessons for continuous agent improvement. |
| 🧭 [ssot-knowledge-graph](./ssot-knowledge-graph/) | `ssot-knowledge-graph` | Knowledge | Connects SSOT files to projects, trackers, status docs, content indexes, and memory pointers. |
| ⚙️ [ssot-setting](./ssot-setting/) | `ssot-setting` | System | Snapshots, backs up, and restores OpenClaw configuration as an SSOT-controlled workflow. |
| 🗂️ [ssot-steward](./ssot-steward/) | `ssot-steward` | Knowledge | Enforces SSOT file naming, versioning, archive, upload, and branded-PDF workflow rules. |
| 🖼️ [Stock Images](./stock-images/) | `stock-images` | Design | Finds free stock photos and placeholder image sources using direct URL patterns and provider guidance. |
| ✅ [tdd](./tdd/) | `tdd` | Coding | Test-driven development workflow using red-green-refactor and behavior-first implementation. |
| 🎫 [to-issues](./to-issues/) | `to-issues` | Product | Turns plans, PRDs, or conversations into prioritized, independently completable issue tickets. |
| 📄 [to-prd](./to-prd/) | `to-prd` | Product | Synthesizes conversation context into a structured Product Requirements Document. |
| 🚦 [triage](./triage/) | `triage` | Workflow | Sorts incoming messages, files, emails, or ideas into prioritized action buckets. |
| 🔍 [ui-audit](./ui-audit/) | `ui-audit` | Design | Audits UI against UX principles: hierarchy, accessibility, cognition, navigation, feedback, and usability patterns. |
| ✨ [ui-ux-pro-max](./ui-ux/) | `ui-ux` | Design | Searchable UI/UX design databases and scripts for styles, palettes, typography, charts, stacks, and design systems. |
| 🌦️ [weather](./weather/) | `weather` | Utility | Gets current weather and forecasts from no-key public weather providers. |
| 📈 [website-seo](./website-seo/) | `website-seo` | Marketing | Universal on-page SEO system covering page optimization, schema, technical checks, internal links, Core Web Vitals, and gaps. |
| 🔭 [zoom-out](./zoom-out/) | `zoom-out` | Strategy | Steps back from details to identify larger patterns, strategic connections, assumptions, and implications. |

## Quick Start

Install one skill by copying its folder into your OpenClaw workspace skills directory:

```bash
git clone https://github.com/XX441/openclaw-skills.git
cp -R openclaw-skills/<skill-folder> ~/.openclaw/workspace/skills/
```

Example:

```bash
cp -R openclaw-skills/tdd ~/.openclaw/workspace/skills/
```

Then restart or refresh OpenClaw so the skill registry can discover the new skill.

## Repository Structure

```text
openclaw-skills/
├── README.md
├── .gitignore
├── agent-team-framework/
│   ├── README.md
│   ├── SKILL.md
│   └── ...
├── coding-discipline/
│   ├── README.md
│   ├── SKILL.md
│   └── ...
└── ...
```

## Contributing

Contributions are welcome.

1. Fork the repository.
2. Add a new skill folder using kebab-case, e.g. `my-new-skill/`.
3. Include a `SKILL.md` with clear frontmatter:

```yaml
---
name: my-new-skill
description: What the skill does, when it should trigger, and what it helps with.
---
```

4. Add a folder-level `README.md` with:
   - Skill name and icon
   - What it does
   - When to use it
   - How to install
   - Files included
5. Keep secrets out of the repo. Do not commit `.env`, tokens, cookies, private configs, or personal data.
6. Open a pull request with a short description and example use case.

## Security & Privacy

This catalog excludes local `.env` files, hidden ClawHub metadata, macOS artifacts, dependency folders, caches, and common secret-bearing files. Skills should use environment variables or external credential stores rather than committed secrets.
