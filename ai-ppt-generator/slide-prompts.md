# Slide Prompt Templates

Parametric templates. Insert brand colors and content before generating.

---

## 1. Title Slide

**Layout:** Full-slide dark background, centered large title, gold subtitle

**Prompt:**

```text
Professional presentation title slide ({aspect}) for {brand}.

Use this {brand} background image as reference. Keep the EXACT same background
- do not add different decorative elements. Maintain the gradient, logo position,
and footer exactly as in the reference.

Content to add (clean, flat design, NO shadows or 3D effects):

Line 1: "[PRIMARY_TITLE]" in {text_light}, very large, bold
Line 2: "[SECONDARY_TITLE]" in {accent}, large
Line 3: "[ENGLISH_SUBTITLE]" in {text_light}, medium

Below that (smaller, light green/white):
[CONTEXT_LINE_1]
[CONTEXT_LINE_2]

Bottom (footer area, matching reference):
[DATE_VENUE]

Flat design. Clean. No drop shadows. No 3D text effects. The background elements
(tree, footer, logo) must match the reference image exactly.
```

---

## 2. Agenda / Table of Contents

**Layout:** Two-column numbered list, thin green accent under title

**Prompt:**

```text
Professional presentation agenda slide ({aspect}) for {brand}.
Use this {brand} background image as reference. Keep background identical.

Title at top-left: "議程 / Agenda" in {primary}, large, bold.

Below the title, list these [N] numbered items in two columns, clean sans-serif font,
{text_primary} text, good spacing:

Column 1:
1. [ITEM_1]
2. [ITEM_2]
3. [ITEM_3]

Column 2:
4. [ITEM_4]
5. [ITEM_5]
6. [ITEM_6]

Keep layout clean and minimal. Thin green accent line under title.
No decorative elements added beyond the background reference.
```

---

## 3. Two-Column Comparison

**Layout:** Left light gray, right dark green. Gold bullets.

**Prompt:**

```text
Professional presentation slide ({aspect}) for {brand}.
Use this {brand} background image as reference exactly - same footer, logo,
tree decoration, and gradient. Do NOT change background elements.

Title at top-left: "[TITLE]" in {primary}, bold.

TWO COLUMNS layout:

LEFT COLUMN (light gray {bg_light} background, rounded corners, about 45% width):
Header "[LEFT_HEADER]" in {primary}
Bullet text in {text_dark}, using {accent} bullets ({bullet_char}):
{LEFT_BULLETS}

RIGHT COLUMN ({primary} background = {bg_dark}, rounded corners, about 45% width):
Header "[RIGHT_HEADER]" in {accent}
Bullet text in {text_light}, using {accent} checkmark bullets ({checkmark}):
{RIGHT_BULLETS}

Clean flat design. No shadows. No 3D effects. {accent} accents only.
No blue or other colors outside brand palette.
```

---

## 4. Three-Card (Pricing / Tiers)

**Layout:** 3 horizontal cards, middle card highlighted

**Prompt:**

```text
Professional presentation slide ({aspect}) for {brand}.
Use this {brand} background image as reference exactly.

Title: "[TITLE]" in {primary}, large, bold.

Create THREE cards arranged horizontally:

CARD 1 (left, {bg_light} background):
Header "[TIER_1_NAME]" in {primary}
Price "[TIER_1_PRICE]" in {primary}, large, bold
"[TIER_1_SUB]" in gray
Line
{TIER_1_FEATURES}
"✗ [EXCLUDED_ITEM]"

CARD 2 (center, {bg_dark} background - HIGHLIGHTED):
Header "[TIER_2_NAME ★]" in {accent}
Price "[TIER_2_PRICE]" in {text_light}, large, bold
"[TIER_2_SUB]" in {bg_light}
Line
{TIER_2_FEATURES}
"✗ [EXCLUDED_ITEM]"

CARD 3 (right, {bg_light} background):
Header "[TIER_3_NAME]" in {primary}
Price "[TIER_3_PRICE]" in {primary}, large, bold
"[TIER_3_SUB]" in gray
Line
{TIER_3_FEATURES}
"✗ [EXCLUDED_ITEM]"

BOTTOM SECTION (full width, {bg_light} box):
[BOTTOM_NOTES]

{brand} brand colors. Clean typography. No decorative elements added beyond reference.
```

---

## 5. Product Cards

**Layout:** 3 vertical cards with icons/arrows

**Prompt:**

```text
Professional presentation slide ({aspect}) for {brand}.
Use this {brand} background image as reference exactly.

Title at top-left "[TITLE]" in {primary}.

Create THREE product cards arranged horizontally across the slide:

Card 1 ({bg_dark} background, rounded corners):
Header "[PRODUCT_1_NAME]" in {text_light}
Below: "[LABEL_1]" in {accent}
Arrow down (→)
"[ACTION_1]" in {text_light}

Card 2 ({bg_dark} background, rounded corners):
Header "[PRODUCT_2_NAME]" in {text_light}
Below: "[LABEL_2]" in {accent}
Arrow down (→)
"[ACTION_2]" in {text_light}

Card 3 ({bg_dark} background, rounded corners):
Header "[PRODUCT_3_NAME]" in {text_light}
Below: "[LABEL_3]" in {accent}
Arrow down (→)
"[ACTION_3]" in {text_light}

Below the cards, a {bg_light} information box spanning full width:
[INFO_TEXT]

Use clean sans-serif fonts ({font_cn} for Chinese). Professional corporate style.
No decorative elements beyond reference background.
```

---

## 6. Process Flow / Timeline

**Layout:** Horizontal connected stages with arrows

**Prompt:**

```text
Professional presentation slide ({aspect}) for {brand}.
Use this {brand} background image as reference exactly.

Title at top-left: "[TITLE]" in {primary}, bold.

Create [N] small connected stage cards arranged horizontally.
Each card is a {bg_dark} rectangle with {text_light} text.
Between each card, place a {accent} arrow (→).

Each card has 3 lines:
Card 1 - "[STAGE_1]" (bold header)
[ACTION_1A]
[ACTION_1B]
[ACTION_1C]

Card 2 - "[STAGE_2]" (bold header)
[ACTION_2A]
[ACTION_2B]
[ACTION_2C]

... (repeat for each stage)

Below the flow diagram, a full-width {bg_dark} bar with {accent} text:
"[GOAL_STATEMENT]"

Flat design. Clean arrows. No shadows. Ensure all text is readable.
```

---

## 7. Full-Image Slide

**Layout:** Single image fills entire slide (for existing assets)

**Prompt:**

```text
Use this image as the full slide content. Paste into a blank slide
at {dimensions} covering the entire area.

No additional text or decoration needed.
```

---

## 8. Thank You / Closing

**Prompt:**

```text
Professional presentation closing slide ({aspect}) for {brand}.
Use this {brand} background image as reference exactly.

Centered text, large:

Line 1: "[THANK_YOU_CN]" in {text_light}, very large
Line 2: "[THANK_YOU_EN]" in {accent}, large

Below, smaller:
[CONTEXT_1]
[CONTEXT_2]

{brand} logo and footer as in reference. Clean flat design. No shadows.
```

---

## Prompt Design Rules

1. **Always include brand specs** at the top of each prompt
2. **Always reference the background image** — keeps template consistent
3. **"Clean flat design. No shadows. No 3D effects."** — prevents AI from adding glossy/shiny elements
4. **"No decorative elements beyond the background reference"** — prevents AI from adding extra trees/icons
5. **Specify exact colors** by hex code, not by name
6. **For Chinese text**, specify `{font_cn}` specifically
7. **For CI/TC variation**, specify Simplified vs Traditional Chinese
