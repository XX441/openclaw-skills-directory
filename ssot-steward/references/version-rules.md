# Version Rules

## Naming Pattern

```
Document_Title_v{MAJOR}.{MINOR}.{PATCH}.ext
```

- Use **Title_Case_With_Underscores** — no spaces, no hyphens
- Include **date** for time-sensitive docs (meeting notes, daily logs)
- Never use vague labels: "Final", "New", "Updated", "Latest"
- Be specific and descriptive

**Good:** `IGSO_GS1_Cooperation_Framework_v1.0.md`
**Bad:** `Final_Framework_New_v2_Final.docx`

## Version Bump Rules

| Bump | When | Example |
|---|---|---|
| **PATCH** (v1.0.0 → v1.0.1) | Typos, formatting fixes only | Fixed missing comma, corrected date |
| **MINOR** (v1.0 → v1.1) | Added sections, significant content updates | Added revenue table, new partner section |
| **MAJOR** (v1.x → v2.0) | Breaking changes, complete rewrites, format changes | Google Doc → HTML, restructured all sections |

## Golden Rule

**Filename version ≡ document body version. Always.**

- Filename: `IGSO_Commercial_Framework_v2.0.html`
- Content must contain: `Version: v2.0` (or equivalent)

Any mismatch is a blocking error. `ssot-upload` enforces this automatically.

## Archive Rule

**One active version only.** After upload, immediately move all older versions of the same document to `_Archive/`.

- Don't delete — archive preserves history
- Verify new file is present and readable before archiving old
- One unified `_Archive/` per project (not scattered sub-archives)

## Pagination Warning

`gog drive ls` paginates at ~20 items. Always exhaust pages:

```bash
gog drive ls --parent <folder_id>              # First page
gog drive ls --parent <folder_id> --page <token>  # Next page (repeat until no "# Next page:")
```

**Never** conclude "file not found" without checking all pages. Real-world failure: GS1 folder was item #24, invisible on page 1.
