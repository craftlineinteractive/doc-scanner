---
name: Doc Scanner
colors:
  surface: '#f8f9ff'
  surface-dim: '#cbdbf5'
  surface-bright: '#f8f9ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#eff4ff'
  surface-container: '#e5eeff'
  surface-container-high: '#dce9ff'
  surface-container-highest: '#d3e4fe'
  on-surface: '#0b1c30'
  on-surface-variant: '#464555'
  inverse-surface: '#213145'
  inverse-on-surface: '#eaf1ff'
  outline: '#777587'
  outline-variant: '#c7c4d8'
  surface-tint: '#4d44e3'
  primary: '#3525cd'
  on-primary: '#ffffff'
  primary-container: '#4f46e5'
  on-primary-container: '#dad7ff'
  inverse-primary: '#c3c0ff'
  secondary: '#006c49'
  on-secondary: '#ffffff'
  secondary-container: '#6cf8bb'
  on-secondary-container: '#00714d'
  tertiary: '#7b3300'
  on-tertiary: '#ffffff'
  tertiary-container: '#a04500'
  on-tertiary-container: '#ffd2bd'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#e2dfff'
  primary-fixed-dim: '#c3c0ff'
  on-primary-fixed: '#0f0069'
  on-primary-fixed-variant: '#3323cc'
  secondary-fixed: '#6ffbbe'
  secondary-fixed-dim: '#4edea3'
  on-secondary-fixed: '#002113'
  on-secondary-fixed-variant: '#005236'
  tertiary-fixed: '#ffdbca'
  tertiary-fixed-dim: '#ffb690'
  on-tertiary-fixed: '#341100'
  on-tertiary-fixed-variant: '#783200'
  background: '#f8f9ff'
  on-background: '#0b1c30'
  surface-variant: '#d3e4fe'
typography:
  headline-xl:
    fontFamily: Inter
    fontSize: 28px
    fontWeight: '700'
    lineHeight: 34px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Inter
    fontSize: 22px
    fontWeight: '600'
    lineHeight: 28px
    letterSpacing: -0.015em
  headline-md:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '600'
    lineHeight: 24px
    letterSpacing: -0.01em
  headline-sm:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '600'
    lineHeight: 22px
    letterSpacing: 0em
  body-lg:
    fontFamily: Inter
    fontSize: 15px
    fontWeight: '400'
    lineHeight: 22px
    letterSpacing: 0em
  body-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
    letterSpacing: 0em
  body-sm:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '400'
    lineHeight: 16px
    letterSpacing: 0.01em
  label-md:
    fontFamily: Inter
    fontSize: 13px
    fontWeight: '500'
    lineHeight: 18px
    letterSpacing: 0.01em
  label-sm:
    fontFamily: Inter
    fontSize: 11px
    fontWeight: '600'
    lineHeight: 14px
    letterSpacing: 0.03em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  gutter: 0.75rem
  margin: 1rem
  space-xs: 0.25rem
  space-sm: 0.5rem
  space-md: 0.75rem
  space-lg: 1rem
  space-xl: 1.5rem
---

## Brand & Style

This design system establishes a focused, high-trust productivity tool tailored for modern mobile document management. The visual atmosphere channels fintech-grade precision: calm, systematic, unbloated, and hyper-legible. The target audience includes professionals, students, and operators requiring fast paper-to-digital workflows where clarity and speed are paramount.

The design movement blends **Corporate / Modern** discipline with **Minimalism**:
- Pure functional typography eliminating visual clutter.
- High-contrast hierarchy separating structural canvas, paper-white content surfaces, and purposeful semantic folders.
- Controlled physical metaphors through ultra-soft ambient elevation rather than heavy structural borders.
- Tactile, deliberate floating action paradigms optimized for single-handed mobile ergonomics.

## Colors

The palette leverages a crisp cool-canvas backdrop with high-contrast surfaces, powered by an authoritative indigo primary anchor and nuanced category tokens.

### Canvas & Base Surfaces
- **Canvas Base:** `#F4F6FA` (Very light grey-blue canvas that provides soft separation for white paper cards).
- **Surface Pure:** `#FFFFFF` (Clean, crisp background for document cards, modals, and sheets).
- **Surface Subdued:** `#EEF2F6` (Input backgrounds, inactive segmented chips, and neutral icon containers).

### Brand & Interactive
- **Primary Accent:** `#4F46E5` (Active states, primary CTA pill, focused outlines, selected badges).
- **Primary Hover / Pressed:** `#4338CA`
- **Primary Container / Tint:** `#EEF2FF`

### Semantic Category & Folder Accents
Distinct paired tokens (Foreground / Pastel Container) to classify document categories:
- **Indigo Category:** `#4F46E5` / `#EEF2FF` (General, Contracts)
- **Amber / Orange Category:** `#F97316` / `#FFF7ED` (Invoices, Receipts)
- **Emerald Category:** `#10B981` / `#ECFDF5` (Tax, Financial, Verified)
- **Rose Category:** `#F43F5E` / `#FFF1F2` (Personal, Medical, ID Cards)

### Specialty & Status
- **Premium Accent:** `#EAB308` / `#FEFCE8` (Crown iconography, premium tags, tier upgrades).
- **Text Primary:** `#0F172A` (Slate 900 for absolute legibility).
- **Text Secondary:** `#64748B` (Slate 500 for metadata, timestamps, page counts).
- **Border / Divider:** `#E2E8F0` (Hairline dividers and structural boundaries).

## Typography

Typography relies entirely on the neutral, neo-grotesque structural clarity of Inter. With a uniform geometric baseline and tall x-height, it ensures immediate scanning of document file extensions, optical character recognition statuses, and time values on 390pt mobile viewport scales.

- **Numerals & Metadata:** Inter’s tabular-like proportions allow seamless vertical alignment in list views showing page counts, file weights (e.g., `2.4 MB`), and capture dates.
- **Weights:** Restricted strictly to Regular (`400`), Medium (`500`), Semi-Bold (`600`), and Bold (`700`).
- **Hierarchy Rules:** Large top navigation headers transition smoothly into sticky compact headers (`headline-md`) upon viewport scroll.

## Layout & Spacing

The layout is optimized specifically for a portrait mobile viewport (base viewport: 390 × 844 px) with dedicated consideration for Android dynamic navigation bars and top status indicators.

- **Screen Margins:** Fixed `16px` (`margin: 1rem`) on horizontal canvas edges, maintaining a consistent optical frame across search bars, folder sections, and list items.
- **Card-to-Card Spacing:** Standardized `12px` (`gutter: 0.75rem` / `space-md: 0.75rem`) vertical and horizontal grid distribution for document cards.
- **Vertical Flow Rhythm:**
  - Section headers to content: `12px` (`space-md`).
  - Section groups (e.g., Folders to Recent Files): `24px` (`space-xl`).
- **Safe Area Insets:** Content containers utilize a bottom padding of `100px` to guarantee that scrolled list items are never obscured by the persistent floating dual-pill CTA.

## Elevation & Depth

This design system avoids heavy borders and hard drop-shadows in favor of ethereal, diffused ambient lighting that mimics real paper stacked on clean desks.

### Elevation Levels
- **Level 0 (Flat):** Used for the background canvas (`#F4F6FA`) and recessed search input wells.
- **Level 1 (Card / Resting Tile):** Pure white cards with an extra-diffused, cool-tinted shadow:  
  `box-shadow: 0 4px 16px -2px rgba(15, 23, 42, 0.04), 0 2px 6px -1px rgba(15, 23, 42, 0.02)`.
- **Level 2 (Active / Swiped / Dropdown):** Lifted cards during drag-to-reorder or menu disclosures:  
  `box-shadow: 0 10px 24px -4px rgba(15, 23, 42, 0.08), 0 4px 8px -2px rgba(15, 23, 42, 0.03)`.
- **Level 3 (Floating Dual Pill CTA):** Highly elevated, tinted indigo ambient glow:  
  `box-shadow: 0 12px 28px -4px rgba(79, 70, 229, 0.35), 0 4px 10px -2px rgba(79, 70, 229, 0.20)`.

### Borders
Borders are minimal. When separation is needed against white backdrops (e.g., document preview thumbnails), use a subtle `1px` inner or outer border of `#E2E8F0`.

## Shapes

The shape system employs roundedness level `2`, producing balanced, modern curves that soften technical mobile scanning without feeling cartoonish.

- **Document Cards & Folder Tiles:** Scaled between `16px` and `20px` corner radii (utilizing `rounded-lg` through `rounded-xl`).
- **Search Fields & Containers:** Uniform `12px` to `14px` border radius.
- **Category Badges & Status Chips:** Fully pill-shaped (`9999px`) for quick organic recognition.
- **Persistent Dual CTA:** Symmetrical full-pill geometry (`9999px`) creating a sleek, single-unit handheld element.

## Components

### Floating Dual Pill CTA
- **Structure:** Centered horizontally at the screen bottom (`bottom: 24px`), height: `56px`. Composed of a single capsule with two primary action zones.
- **Color & Material:** Background `#4F46E5`, crisp white icons (`#FFFFFF`).
- **Layout:**
  - Left segment: Fast Scan (`Camera` icon, 22px stroke).
  - Divider: 1px vertical hairline in `rgba(255, 255, 255, 0.25)`, height 24px.
  - Right segment: Import / New Folder (`Plus` icon, 22px stroke).
- **Feedback:** Scale transform down to `0.96` on touch press.

### Document Cards (Grid & List)
- **Background & Shape:** Pure white (`#FFFFFF`), `16px` or `20px` radius, Elevation Level 1.
- **Card Preview Area:** High-contrast document thumbnail displaying edge detection margins with a 1px border (`#E2E8F0`).
- **Metadata Layout:** File title in `headline-sm`, trailing three-dot context action (Lucide `MoreVertical`, 18px), subtext line with category pill + relative timestamp (`body-sm`).

### Folder Category Tiles
- **Container:** Horizontal scroll or 2-column grid. Radius `16px`.
- **Styling:** Pastel container background (e.g., `#EEF2FF`, `#FFF7ED`, `#ECFDF5`, `#FFF1F2`).
- **Iconography:** Lucide-style thin outline (1.75px stroke width) inside an 8px padded round badge colored with the category foreground token.
- **Folder Metric:** Category name in `headline-sm` with item count underneath in `body-sm`.

### Input & Search Bar
- **Surface:** Recessed pill or 14px rounded rectangle in pure white (`#FFFFFF`) or light surface (`#EEF2F6`).
- **Icons:** Leading Lucide `Search` (18px, `#64748B`), trailing optional filter icon (`SlidersHorizontal`, 18px).
- **Border:** Invisible at rest, `#4F46E5` focus ring (1.5px).

### Premium Header / Crown Pill
- **Affordance:** Compact badge placed in the top right app bar or profile area.
- **Styling:** Soft container `#FEFCE8`, border `1px solid rgba(234, 179, 8, 0.2)`.
- **Icon & Text:** `#EAB308` filled crown, text "PRO" or "PREMIUM" in `label-sm` (bold, tracking uppercase).

### Iconography Rules
- All icons must follow Lucide line-style conventions with a consistent `1.75px` to `2px` stroke width, rounded caps, and rounded joins. Never use heavy filled icon sets except for specific verified states and the premium crown.