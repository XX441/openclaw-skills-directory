# PDF Generation Workflow (pdfgen)

## When to Use

Use `pdfgen` for **every** branded PDF. No exceptions. Never hand-roll HTML with inline styles — the template exists for a reason.

## Command

```bash
pdfgen <file.md> --brand igso [title] [doc_id] [date] [doc_type]
```

If you omit title/doc_id/date/doc_type, pdfgen infers from the markdown:
- **title** ← first H1 heading
- **doc_id** ← filename (without extension)

## Available Brands

| Brand | Flag | Use Case |
|---|---|---|
| IGSO | `--brand igso` | IGSO standards, frameworks, official docs |
| AWWWS | `--brand awwws` | AWWWS platform materials |
| Frutodor | `--brand frutodor` | 果臨門 materials |
| Frutus | `--brand frutus` | Frutus Charitable Foundation |
| BD | `--brand bd` | Business development decks/proposals |

## Templates

Templates live at `~/.openclaw/workspace/templates/pdf/`. Each brand has:
- Logo rendered at 63px height
- Correct brand colors and fonts
- A4 output via Playwright Chromium

## Pipeline

```
markdown → template → Playwright Chromium → A4 PDF
```

## Anti-Patterns (Never Do)

❌ Custom HTML with manual `<style>` blocks
❌ Inline CSS on every element
❌ Copying template CSS into a one-off file
❌ `wkhtmltopdf` or other PDF engines

✅ `pdfgen` always. If it breaks, fix the tool, not the output.

## Full Usage Example

```bash
pdfgen IGSO_Commercial_Framework_v2.0.md \
  --brand igso \
  "IGSO Commercial Framework" \
  "IGSO-COM-FW-001" \
  "2026-05-07" \
  "标准文件 / STANDARD DOCUMENT"
```
