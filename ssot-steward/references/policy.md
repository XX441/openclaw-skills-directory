# Good Steward Legacy - SSOT Policy Master Document

**Purpose:** Reference manual for file/folder/version edge cases and detailed procedures  
**Usage:** Look up specific sections when needed (like a dictionary)  
**Daily Rules:** See `HEARTBEAT.md` section "⚡ Quick Rules" for the simple 5-rule checklist  
**Scope:** Entire `Good Steward Legacy` vault (Google Drive)  
**Last Updated:** 2026-04-28  
**Owner:** Leo Cheung / IGSO Team

---

## 🚀 Quick Start: When to Use This Document

**For daily file operations:** → See `HEARTBEAT.md` "⚡ Quick Rules" (5 simple rules)

**Use this master policy when:**
- You need detailed procedures for complex scenarios
- You want to understand the "why" behind the rules
- You need CLI commands or technical references
- You're handling edge cases (duplicates, ambiguous versions, etc.)
- You're training new team members
- You're doing weekly/monthly structure audits

**Think of this as:** A reference manual, not a daily checklist.

---

## 📖 Table of Contents

1. [Core Principles](#1-core-principles)
2. [Folder Structure & Lanes](#2-folder-structure--lanes)
3. [File Naming Convention](#3-file-naming-convention)
4. [Version Control System](#4-version-control-system)
5. [Pre-Flight Checklist](#5-pre-flight-checklist)
6. [Obsidian Automation Rules](#6-obsidian-automation-rules)
7. [Archive & Cleanup Policy](#7-archive--cleanup-policy)
8. [Quality Assurance Checks](#8-quality-assurance-checks)
9. [Tools & Commands](#9-tools--commands)

---

## 1. Core Principles

### 1.1 Single Source of Truth (SSOT)
- **One active version** of each document in the working folder
- **Clear distinction** between master, draft, and archive
- **No ambiguity** about which file is current

### 1.2 Google Drive = SSOT
- **Good Steward Legacy lives on Google Drive**, NOT local workspace
- **Drive Folder ID:** `1dUYGLMcicYpHuUdO6Jqnv3kqVdEAJ74j`
- **Local workspace = scratch only** (temporary work files)

### 1.3 Automated Enforcement
- Java runs **pre-flight checks** before every file operation
- Java performs **post-operation audits** after uploads
- Java maintains **version consistency** automatically

### 1.4 Restructure Principles (Learned from IGSO Project Migration)
- **One unified _Archive/**, not scattered archive folders across subfolders
- **No LINK_*.md fragile references** — place content directly where it belongs
- **.md as SSOT** — all legacy .docx → _Archive/
- **Old_Structure/ as backup** — preserve original layout for reference before cleanup
- **PROJECT_INDEX.md at root** — navigation entry point
- **Title_Case_With_Underscores** throughout, no spaces/hyphens/CN-English mixes

---

## 2. Folder Structure & Lanes

### 2.1 Four Core Lanes

```
Good Steward Legacy/
├── 01_Pipelines/           # BD opportunities, partners, institutions
├── 02_Platform_Knowledge/  # Standards, policy, IP, reusable knowledge
├── 03_Execution_Projects/  # Active deliverables, websites, implementation
└── 04_Shared_Assets/       # Brand assets, photos, logos, media
```

### 2.2 Lane Usage Rules

| Lane | Use For | Examples |
|------|---------|----------|
| **01_Pipelines** | Business development, partnerships, proposals | GS1, CMA Testing, Sunny Chau/CEDB |
| **02_Platform_Knowledge** | Canonical knowledge, standards, frameworks | IGSO standards, policy documents, IP |
| **03_Execution_Projects** | Active project work, deliverables | Websites, decks, meeting notes, drafts |
| **04_Shared_Assets** | Media, brand assets, templates | Logos, photos, newsletters, visual collateral |

### 2.3 Standard Project Subfolders

**For projects in `02_Platform_Knowledge`: (Reference Structure — IGSO Project)**
```
Project_Name/
├── 01_Core_Identity/       # Master doc, brand, intro, summaries
├── 02_Standards/           # All standards docs unified
├── 03_Technology_IP/       # Patents, protocol logic, proposals
├── 04_Policy_Landscape/    # Relevant policy documents
├── 05_Partner_Network/     # Partner profiles (WUWM, GS1, CMA, etc.)
├── 06_Deployment_Visits/   # Visits, speaking events (e.g. 2026_05_Beijing/)
├── 07_Content_Assets/      # Videos, platform visuals
├── _Archive/               # Unified archive (one folder, not scattered)
└── PROJECT_INDEX.md        # Root-level navigation
```

**For projects in `03_Execution_Projects`:**
```
Project_Name/
├── 01_Background/
├── 02_Meetings/
├── 03_Decks_Proposals/
├── 04_Drafts/
├── 05_Reference/
├── _Archive_Legacy/
└── 00_PROJECT_STATUS.md
```

---

## 3. File Naming Convention

### 3.1 Standard Format

**Pattern:** `Document_Title_v{MAJOR}.{MINOR}.{PATCH}.ext`

**Examples:**
- `IGSO_Commercial_Framework_v2.0.0.html`
- `GS1_Cooperation_Agreement_v1.3.2.pdf`
- `Meeting_Notes_2026-04-28_v1.0.md`

### 3.2 Version Number Meaning

| Component | When to Increment | Example |
|-----------|-------------------|---------|
| **MAJOR** | Breaking changes, complete rewrites, new format | v1.0 → v2.0 (Google Doc → HTML) |
| **MINOR** | Added sections, significant content updates | v2.0 → v2.1 (added revenue table) |
| **PATCH** | Typos, formatting fixes only | v2.0 → v2.0.1 (fixed typo) |

### 3.3 Title Formatting Rules

- Use **Title_Case_With_Underscores**
- Include **date** for time-sensitive documents (meeting notes, daily logs)
- Avoid vague names like "Final", "New", "Updated"
- Be **specific and descriptive**

**Good:** `IGSO_GS1_Cooperation_Framework_v1.0.md`  
**Bad:** `Final_Framework_New_v2_Final.docx`

---

## 4. Version Control System

### 4.1 Golden Rule

**The version number in the FILENAME must match the version number IN THE DOCUMENT.**

✅ **Correct:**
- Filename: `IGSO_Commercial_Framework_v2.0.html`
- Content: `Document Version: v2.0`

❌ **Wrong:**
- Filename: `IGSO_Commercial_Framework_v2.0.html`
- Content: `Document Version: v1.0`

### 4.2 Version Update Procedure

**Before creating a new version:**

1. **Search for existing versions:**
   ```bash
   gog drive search "Document Title"
   ```

2. **Determine update type:**
   - MAJOR, MINOR, or PATCH?

3. **Update ALL version mentions in content:**
   - Footer/version line
   - Title page (if exists)
   - Metadata fields
   - Change log

4. **Verify consistency:**
   ```bash
   grep -i "version\|v[0-9]" /tmp/your_file.ext
   ```

5. **Rename file** to match new version

6. **Archive/delete old version** immediately after upload

### 4.3 Change Log Policy

For important documents, add a version history section:

```markdown
## Version History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| v2.0.0 | 2026-04-28 | Leo | Converted to HTML, fixed table formatting |
| v1.0.0 | 2026-04-27 | Leo | Initial draft in Google Docs |
```

---

## 5. Pre-Flight Checklist

**⚠️ MANDATORY: Run this checklist BEFORE creating, updating, or sharing ANY file**

### Step 1: Search for Existing Versions
- [ ] Are there existing versions of this document?
- [ ] What version numbers are in use?
- [ ] Which folder(s) contain them?

### Step 2: Determine Version Strategy
- [ ] Is this MAJOR, MINOR, or PATCH update?
- [ ] Plan: Archive or delete old version?
- [ ] Verify: Update ALL version mentions in content

### Step 3: Create/Update Content
- [ ] Embed version number in content (footer, title page, metadata)
- [ ] Use consistent naming throughout document
- [ ] Add change log entry if this is an update
- [ ] Search-and-replace ALL old version numbers

### Step 4: Pre-Upload Verification
- [ ] Filename version = Content version
- [ ] No old version numbers remain in content
- [ ] Change log updated (if applicable)
- [ ] Correct target folder identified

### Step 5: Upload & Clean Up
- [ ] Verify file uploaded to correct folder
- [ ] Open file to confirm it renders correctly
- [ ] Archive or delete old versions
- [ ] Confirm only ONE active version exists in working folder

### Step 6: Post-Operation Audit
- [ ] Only one active version in working folder
- [ ] Old versions moved to `_Archive_Legacy` or deleted
- [ ] File name follows convention: `Title_v{MAJOR}.{MINOR}.{PATCH}.ext`
- [ ] File is in correct lane folder

---

## 6. Obsidian Automation Rules

### 6.1 Auto-Conversion Policy

**Files to auto-convert to Markdown:**
- `.txt` files
- `.docx` files
- Google Docs exports
- Meeting notes, proposals, discussion papers

**Conversion Rules:**
1. Create `.md` file in same folder as source
2. Preserve meaning and structure faithfully
3. Use Markdown headings, bullets, spacing for readability
4. Add YAML frontmatter when useful:
   ```yaml
   ---
   status: active
   type: note
   source: converted_from_docx
   ---
   ```
5. Don't destroy original until conversion verified
6. Move original to `_Archive_Legacy` after verification

### 6.2 Duplicate Handling

**When multiple versions exist:**

1. **Don't immediately delete**
2. **Determine type:**
   - Master
   - Draft
   - Commented copy
   - Converted legacy copy
   - Duplicate clutter
3. **If certainty is high:**
   - Rename current working master clearly
   - Move superseded files to `_Archive_Drafts` or `_Archive_Legacy`
4. **If certainty is low:**
   - Leave files in place
   - Note the ambiguity
   - Ask for clarification

### 6.3 Linking Policy

Add Obsidian wiki-links to connect related materials:
- Link proposals to pipelines/projects
- Link execution docs to core knowledge papers
- Link meeting notes to related proposals

**Don't add excessive links** — prefer meaningful contextual connections.

---

## 7. Archive & Cleanup Policy

### 7.1 What to Archive

Move to `_Archive_Legacy`:
- Superseded versions (after new version verified)
- Converted source files (after .md conversion verified)
- Draft documents no longer serving as active masters
- Commented working copies
- Legacy formats replaced by new standards

### 7.2 Archive Rules

1. **Don't delete too early** — verify new file first
2. **Prefer archiving over deletion** — preserves history
3. **Keep active masters in working folder**
4. **Only archive after new file confirmed present and readable**

### 7.3 Deletion Guidelines

**Safe to delete:**
- Obvious duplicate clutter (identical files)
- Temporary working copies
- Broken/corrupted files with replacements

**Ask before deleting:**
- Files with unclear ownership
- Documents that might be referenced elsewhere
- Anything that seems sensitive or externally shared

---

## 8. Quality Assurance Checks

### 8.1 Daily Heartbeat Checks

During heartbeat cycles (2-4x/day):

- [ ] Scan folders for new/updated files
- [ ] Detect legacy files needing conversion
- [ ] Check for version mismatches
- [ ] Identify duplicate files
- [ ] Verify folder structure compliance

### 8.2 Pre-Share Document Checks

**BEFORE sharing ANY external document:**

- [ ] Filename version matches content version
- [ ] Old versions archived (not deleted)
- [ ] Change log updated (if applicable)
- [ ] File opens correctly in target application
- [ ] Correct folder location verified (SSOT compliance)

### 8.3 Weekly Structure Audit

**Every Friday during weekly review:**

- [ ] No orphaned files in root folders
- [ ] All projects have standard subfolder structure
- [ ] Archive folders are organized (not dumping grounds)
- [ ] No ambiguous duplicate files remain
- [ ] Version numbers are consistent across all documents

---

## 9. Tools & Commands

### 9.1 Google Drive CLI (`gog drive`)

```bash
# List folder contents (watch for pagination!)
gog drive ls --parent <folder_id>

# Search for files
gog drive search "filename pattern"

# Get file details
gog drive get <file_id>

# Upload file
gog drive upload /path/to/file --parent <folder_id> --name "filename.ext"

# Move file
gog drive move <file_id> --parent <new_folder_id>

# Delete file
gog drive rm --force <file_id>

# Rename file
gog drive rename <file_id> "new_name.ext"
```

### 9.2 Google Docs CLI (`gog docs`)

```bash
# Create new Google Doc
gog docs create "Document Title"

# Write content to Google Doc
gog docs write <doc_id> --file /path/to/content.txt

# Clear Google Doc content
gog docs clear <doc_id>
```

### 9.3 Version Control Commands

```bash
# Find version mentions in file
grep -i "version\|v[0-9]" filename.ext

# Replace version numbers (careful!)
sed -i '' 's/v1\.0/v2.0/g' filename.ext

# Compare two file versions
diff -u old_file.txt new_file.txt

# Extract version from filename
basename file_v2.0.ext | grep -o 'v[0-9.]*'
```

### 9.4 Pagination Warning

**⚠️ CRITICAL:** `gog drive ls` paginates at ~20 items

**Always check for next page:**
```bash
# First page
gog drive ls --parent <folder_id>

# If output shows "# Next page:", fetch next page
gog drive ls --parent <folder_id> --page <token>

# Repeat until no more "# Next page:"
```

**Real-world failure example:** GS1 folder was item #24. First page showed 20 items, so I incorrectly concluded "folder doesn't exist." Second page revealed it.

---

## 📋 Quick Reference Cards

### File Creation Checklist
- [ ] Searched for existing versions
- [ ] Determined MAJOR/MINOR/PATCH update type
- [ ] Named file: `Title_v{MAJOR}.{MINOR}.{PATCH}.ext`
- [ ] Embedded version in content
- [ ] Identified correct lane folder
- [ ] Ran pre-flight verification

### Upload Checklist
- [ ] Filename version = Content version
- [ ] Correct parent folder ID verified
- [ ] File opens/renders correctly
- [ ] Old versions archived/deleted
- [ ] Only one active version remains

### Folder Structure Checklist
- [ ] File in correct lane (01/02/03/04)
- [ ] Project has standard subfolders
- [ ] Archive folder used for old versions
- [ ] No files orphaned in root

---

## 🚨 Common Mistakes & Fixes

| Mistake | Prevention | Fix |
|---------|------------|-----|
| Version mismatch (filename ≠ content) | Pre-flight checklist, grep verification | Search-and-replace all mentions, re-upload |
| Multiple active versions | Archive old version immediately | Move old versions to `_Archive_Legacy` (Execution) or `_Archive/` (Platform) |
| Wrong folder location | Verify parent folder ID before upload | Use `gog drive move` to relocate |
| Pagination false negatives | Always check for "# Next page:" | Fetch all pages before concluding "not found" |
| No change log | Add version history section | Retroactively create change log |
| Scattered archive folders | One unified _Archive/ per project | Merge all archive folders into one |
| LINK_*.md fragile references | Place content directly in correct folder | Delete LINK files, verify content in proper location |
| Spaces/hyphens in names | Use Title_Case_With_Underscores | Rename files to consistent format |

---

## 📖 Related Documents

- **HEARTBEAT.md:** Daily operational checklist
- **AGENTS.md:** Workspace conventions and session startup
- **TOOLS.md:** Local tool configurations and credentials

---

## 🔄 Document Maintenance

**This policy document should be:**
- Reviewed quarterly for accuracy
- Updated when new patterns emerge
- Referenced in onboarding for new team members
- Enforced automatically by Java during file operations

**Last reviewed:** 2026-04-28  
**Next review due:** 2026-07-28

---

*Consolidated from:*
- *obsidian-automation-policy.md*
- *document-version-control-sop.md*
- *file-operations-preflight-checklist.md*

*These legacy files are now deprecated and superseded by this master document.*
