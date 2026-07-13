# DESIGN.md: Ben & Shannon Wedding Site

The visual system comes from the couple's commissioned design packet (a Claude
Design handoff). Tokens live at the top of
[`assets/css/main.css`](assets/css/main.css); this file explains intent and the
layout system built on top.

## Palette (from a rainbow trout)

Semantic roles, not raw ramps, in product code.

- **Cream** `--surface-page #faf6ef` is the ground. Never white page bg.
- **Sage** `--accent-primary #5f6f4f` is the primary brand (foliage, the trout's flank).
- **Gold** `--accent-gold #b8975a` is linework and small accents **only**: never large flat fills.
- **Blush / coral** `--accent-secondary`, `--accent-coral` are the warm romantic notes.
- **Steel-blue** `--accent-blue #6d919b` is the cool accent (the salmonid's back and gill). It gives the palette a second, cooler pole so it reads as the whole fish, not just sage+blush.
- **Dark sections** alternate two backdrops: warm **pine** `--surface-invert #33422f` and cool **teal-blue** `--surface-invert-blue #2c454f`. Gold linework and cream text sit on both.

Warm/cool balance is the point of v2: warm pages (Schedule, Home welcome) lean
sage/gold/blush; cooler pages (Travel, Things to Do) lean steel-blue/teal.

## Type (4 roles: a committed identity, do not swap)

- **Marcellus**: display/headings, UPPERCASE with wide tracking (`--ls-wide`/`--ls-wider`).
- **Cormorant Garamond**: subtitles (italic) and long reading copy.
- **Jost**: all UI: nav, labels, buttons, eyebrows.
- **Pinyon Script**: the couple's names and the `&` only. Never body or UI.

Google Fonts substitutions (packet supplied no files); swap for `@font-face` if
licensed faces arrive. Marcellus/Cormorant are on impeccable's reflex-reject
list, but identity-preservation wins: this is the brand's committed choice.

## Motif: the arch

An architectural niche: `--radius-arch: 50% 50% 0 0 / 40% 40% 0 0` (straight
vertical sides, curved crown over the top ~40%). Used to frame images, names,
and content, often in a triptych of three. Secondary deco: thin gold keylines,
diamond/sunburst ornaments (`.bs-divider`, `.bs-eyebrow`), and the custom SVG
deco plates in [`_includes/deco-plate.html`](_includes/deco-plate.html).

## Layout system (v2: no central column)

The v1 site was one 38-44rem centered column ("blog" feel). v2 uses the full
viewport with a small set of composable pieces:

- **`.band`**: a full-bleed horizontal section (breaks out to `100vw`). Tones:
  default cream, `--raised`, `--sage`, `--pine`, `--teal`. This is how sections
  get their own color world (art direction per section).
- **`.wrap`**: the max-width inner container (`--measure-wide`, ~72rem) with
  fluid gutters. `.wrap--narrow` for text-forward sections.
- **`.split`**: asymmetric two-column (text + arch/image), stacks on mobile.
- **`.tiles`**: `repeat(auto-fit, minmax(...))` responsive grids for events,
  hotels, restaurants, attractions. No fixed breakpoints.
- **`.timeline`**: the day-of schedule: a centered gold spine with diamond
  nodes, events alternating sides on desktop, stacking on mobile.
- **`.prose`**: only for genuinely long copy (FAQ answers, intros), capped
  ~65ch. It is a component now, not the page skeleton.

Pages own their full structure (HTML + Liquid, not markdown) so they can compose
bands/splits/tiles. The layout renders a hero band from front matter
(`eyebrow` / `title` / `subtitle` / `hero_tone`) then `{{ content }}`.

## Imagery

Image-led by design. Real photos come from the couple later; until then, every
image slot holds a custom **art-deco SVG deco plate** (fan/sunburst, nouveau
tulip, nested arches, trout scales) in the trout palette: genuine on-brand
imagery, not gray placeholder blocks, and a one-line swap to `<img>` later. The
packet's inspiration images (trout, deco interiors) are reference-only and are
NOT used as site content.

## Motion

Gentle and composed (deco is dignified): soft fades and short rises
(`--ease-out`, `--dur-*`), staggered where a group reveals together. No bounce,
no parallax spectacle. Every animation has a `prefers-reduced-motion` fallback.
Gold focus ring, 3px offset.
