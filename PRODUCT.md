# PRODUCT.md: Ben & Shannon Wedding Site

register: brand

## What this is

An informational wedding website for Ben & Shannon, hosted on GitHub Pages
(Jekyll 4). It is guests' "home base": event details, travel and lodging,
things to do, and answers. No forms, no RSVP, no registry. It communicates and
reassures; it does not transact.

## Audience

Wedding guests (friends and family, a range of ages and tech comfort) planning a
trip: figuring out where the venue is, where to stay, where to park, how to get
there, and how to fill a weekend in the area. They arrive on phones and laptops,
often skimming for one specific fact.

## Voice

Warm, first-person-plural ("we"/"you"), relaxed, gracious, a little playful.
Sentence case for body; Title Case for page names. No emoji. Unconfirmed details
read softly: *"To be announced." / "Details to come."* The ampersand in
"Ben & Shannon" is a brand glyph, set in the script face.

## Brand / aesthetic

"Romantic art-deco garden." Composed and symmetrical (deco), softened by
botanicals and blush (garden). The palette is derived from a rainbow trout:
cream ground, sage-green primary, brushed-gold linework, blush/coral warm notes,
**steel-blue cool accent**, deep pine and deep teal-blue for dark sections. The
signature motif is the **arch** (an architectural niche). Full system in
[DESIGN.md](DESIGN.md); source of truth is the design packet the couple
commissioned. This is a committed brand identity, not a greenfield choice:
preserve its fonts (Marcellus / Cormorant Garamond / Jost / Pinyon Script),
motifs, and palette.

## Pages

- **Home**: hero, welcome, and the way into the three planning pages.
- **Schedule**: venue location and the day-of schedule, with a pointer to parking.
- **Travel & Stay**: hotel room blocks, getting here, and parking + transit (the `#parking` section).
- **Things to Do**: recommended sites and attractions in the area.
- **FAQ**: where to stay, day-of schedule, venue, parking, getting there.

## Constraints

- Static Jekyll on GitHub Pages; no build step beyond Jekyll; no JS frameworks.
- All internal links use the `relative_url` filter (project subpath today,
  custom domain later).
- Engagement photos are in (home hero, home welcome, two Travel & Stay slots,
  FAQ closer); deco plates still hold the concept slots. Remaining copy stays
  placeholder until the couple supplies the details.
