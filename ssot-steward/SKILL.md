---
name: ssot-steward
description: SSOT File Steward — enforces naming, versioning, archive, and upload rules for Good Steward Legacy Google Drive file operations. Use for any "gog drive upload", "gog drive replace" / "--replace", "Good Steward Legacy", "Google Drive", "SSOT", "version bump", "version number", "upload to drive", "drive file", "branded PDF", "pdf generation", "pdfgen", "file naming", "archive", "pre-flight check", "ssot-upload", "ssot-convert", or "ssot-audit". Also use for IGSO document management, file versioning, branded PDF creation, and any operation touching the Good Steward Drive root (1dUYGLMcicYpHuUdO6Jqnv3kqVdEAJ74j). Part of the ssot-* skill family.
---

# SSOT File Steward (ssot-steward)

Part of the **ssot-* skill family**. Sibling: `ssot-knowledge-graph` (connecting ideas/dots).

## Mandatory Pre-Upload Gate

**Every `gog drive upload` or `--replace` MUST go through `ssot-upload`, never raw `gog`.**

```bash
scripts/ssot-upload /path/to/file --parent <folder_id> [--name "Name_v1.0.ext"] [--replace <file_id>]
```

The wrapper enforces:
- Collision detection — blocks upload if target name already exists
- Filename version ≡ content version check
- Auto-archive of old matching files after successful upload

**Do NOT bypass this script.** If `ssot-upload` blocks, fix the issue (bump version, align version numbers) — don't reach for raw `gog`.

## Mandatory Branded PDF Rule

**Always use `pdfgen` for branded PDFs. Never hand-roll HTML.**

```bash
pdfgen <file.md> --brand igso [title] [doc_id] [date] [doc_type]
```

Available brands: `igso`, `awwws`, `frutodor`, `frutus`, `bd`

Templates at `~/.openclaw/workspace/templates/pdf/`. If pdfgen breaks, fix the tool, not the output.

See [pdfgen-workflow.md](references/pdfgen-workflow.md) for full details.

## Golden Rule

**Filename version number MUST match the version number in the document body.** Any mismatch is a blocking error.

## Available Scripts

| Script | Purpose |
|---|---|
| `scripts/ssot-upload` | Pre-upload gate — collision detection, version check, auto-archive |
| `scripts/ssot-convert` | Simplified ↔ Traditional Chinese via OpenCC with auto-version bump |
| `scripts/ssot-audit` | Folder compliance scanner — naming, versions, TBC, mismatches |

## Navigation

| When you need… | Read… |
|---|---|
| Version bump rules, naming conventions, archive policy | [version-rules.md](references/version-rules.md) |
| When and how to generate branded PDFs | [pdfgen-workflow.md](references/pdfgen-workflow.md) |
| Pre-share checklist before sending files externally | [pre-share-checklist.md](references/pre-share-checklist.md) |
| The full SSOT policy reference (300+ lines) | [policy.md](references/policy.md) |

## 🔍 Pagination Protocol

`gog drive ls` paginates at ~20 items. **Always exhaust pages before concluding "not found."** Check for `# Next page:` in output and fetch remaining pages with `--page <token>`.
