# AI PPT Generator Skill

Generate professional presentation decks using AI image generation + automated PPTX assembly. Supports multiple brand templates (IGSO, Awwws, Frutodor, BD, Frutus).

## Trigger

- "Create a deck for [topic] using [brand] template"
- "Build a [brand] presentation on [topic]"
- "Generate a PPT for [meeting/client]"

## Workflow

### Phase 0: Setup Brand

Ensure the brand folder exists under `brands/` with:
- `background.png` — 16:9 template (1792×1024px), content area blank, footer/logo baked in
- `config.json` — brand colors, fonts, defaults

If missing, either create or fall back to IGSO defaults.

### Phase 1: Plan Slides

1. Understand the topic, audience, meeting context
2. Decide slide structure (title, agenda, content slides, closing)
3. Map each slide to a prompt template (see `slide-prompts.md`)
4. Write specific content for each slide

### Phase 2: Generate Slides (Sequential)

For each slide:
1. Load `brands/[brand]/config.json` — inject brand colors into prompt
2. Load `slide-prompts.md` — pick the right layout template
3. Fill in content
4. Call `image_generate` with:
   - `prompt`: composed prompt (template + brand specs + content)
   - `image`: `brands/[brand]/background.png` (style reference)
   - `size`: `1792x1024`
   - `filename`: `slide-{NN}-{slug}.png`

Rules:
- Generate ONE slide at a time (sequential, quality over speed)
- After each generation, check OCR/text for errors
- Regenerate if text is garbled or layout broken
- Save each slide to working directory

### Phase 3: Assemble PPTX

```bash
python3 assembly.py \
  --slides slide-*.png \
  --brand igso \
  --output "Deck_Name_v1.0.pptx"
```

Or use the Python API directly:

```python
from assembly import build_deck

build_deck(
    slides=[...],        # list of slide image paths
    brand="igso",        # brand config to use for metadata
    output="deck.pptx",  # output path
    video_slide=3,       # optional: which slide has embedded video
    youtube_url="..."    # YouTube embed URL for that slide
)
```

The script:
- Creates a blank 16:9 presentation
- Pastes each image as full-bleed slide
- Optionally embeds a YouTube video on a specified slide
- Removes unnecessary embedded media
- Saves as PPTX

### Phase 4: Upload to Drive

```bash
ssot-upload "Deck_Name_v1.0.pptx" \
  --parent [folder-id] \
  --name "Deck_Name_v1.0.pptx"
```

Always use `ssot-upload`, never `gog drive upload` directly.

### Phase 5: Version on Content Change

If content is corrected/re-generated:
- Bump version (v1.0 → v1.1 → v1.2)
- Delete old version from Drive
- Upload new version

## Prompt Assembly Rules

Every prompt must include these **brand specs** (sourced from config.json):

```text
Brand: [name]
Primary color: [hex]
Accent color: [hex]
Font: [font name]
Style: Clean, flat, minimal shadows, no 3D effects
Footer: "[footer text]"
Background reference: [background.png]
```

Plus these **quality rules**:
- "No decorative trees or abstract shapes unless specified"
- "DO NOT change the background template — keep footer, logo, and graphics identical to the reference"
- "Use proper [language] — natural not translated-sounding"
- "Flat design. No drop shadows."

## Brand Config Format

```json
{
  "name": "IGSO",
  "primary": "#273F20",
  "accent": "#C8A852",
  "text_dark": "#333333",
  "text_light": "#FFFFFF",
  "bg_light": "#F5F5F0",
  "bg_dark": "#273F20",
  "font_cn": "Microsoft JhengHei",
  "font_en": "Arial",
  "footer_line1": "Confidential & Proprietary | © 2026 International Growers Standards Organization (IGSO). All Rights Reserved.",
  "footer_line2": "机密及专有信息 | © 2026 国际农民标准组织（IGSO）。保留所有权利。",
  "dimensions": "1792x1024",
  "aspect_ratio": "16:9"
}
```

## Slide Count Rule

Decks should be 8–12 slides for most meetings. More than 14 loses attention. Minimum viable deck:
1. Title
2. Agenda (if >5 slides)
3-8. Content
N. Thank You / Next Steps

## YouTube Video Embed

To embed a YouTube video:
1. Include `video_slide=N` and `youtube_url="..."` in `build_deck()`
2. The assembly script handles the XML injection
3. Video thumbnail appears as poster; plays on click in PowerPoint
