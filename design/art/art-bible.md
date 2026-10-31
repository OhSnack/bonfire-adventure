# Art Bible: Bonefire (working title)

> **Status**: Draft
> **Owned By**: art-director
> **Last Updated**: 2026-10-31
> **Art Director Sign-Off (AD-ART-BIBLE)**: [Not yet reviewed]

`/art-bible` writes these nine sections in this order and replaces each
section's `[To be designed]` line as that section is approved. A section still
holding its placeholder is incomplete; a later run fills only those.

## 1. Visual Identity Statement

### The rule

**Each memory returns a little colour.**

The world and the hero begin muted: pale bone, cool shadow, dim flame. Each
recovered memory adds warmth, saturation or detail, so the player sees the story
working. Loss is shown as missing colour, never as anything graphic, which keeps
death honest but gentle. When a visual choice is unclear, ask: does this let
colour return in a way the player can see?

### Supporting principles

**1. Combat information is always at full strength** (Pillar 1: Tactical, not luck-driven)
The muted palette never applies to what the player plans around. Intents, door
previews, Ignite, Weak and block use fixed, high-contrast colours and shapes from
the first fight onward, so they read on a phone and in the plainer glow of the
Compatibility renderer (browser builds).
*Design test:* when a muted look and a battle signal conflict, choose the signal
at full strength.

**2. Companions are the first warmth the player sees** (Pillar 2: Spirits as partners)
Nerlings are soul flames, the warmest thing on the player's side even in dim
early scenes. Charging brightens them, and primed is their strongest glow before
they unleash.
*Design test:* when it's unclear what should carry warmth early on, choose the
companion.

**3. Life returns to the hero and the world, not a new shape** (Pillar 3: A story you earn)
Progress is added warmth and colour, never a change of shape. The hero is a small
skeleton boy with hair from the start (drawn as clear pixel locks, never soft
fuzz), so he reads as relatable. His silhouette and hair shape stay fixed; only
their colour warms, the hair from ashen toward a warmer tone.
*Design test:* when choosing how to show progress, choose added colour over a
change to the hero's form.

### Dog-clue constraint

The hero is secretly the child's dog (see `design/gdd/game-concept.md`, Unique
Hook). The clues stay very subtle so the twist is not spoiled.

- **Allowed in:** rare small habits (a head tilt in an idle animation, circling
  before sitting) and one or two dialogue lines, at most about one per memory
  chapter, never in combat.
- **Scent** is the in-world reason the hero senses enemy intents and what lies
  behind the next door. It is shown only as **spirit wisps**: a thin thread of
  soul-light rises from an enemy, or drifts through a door's gap, and settles
  into a solid, still, high-contrast icon (principle 1). The wisp carries the
  icon; it is not the icon. Wisp motion stops once the icon lands and is off
  under reduced motion. No nose or snout icons, no sniffing animation when
  intents appear, no trails tracked by the hero's head, no paw prints, no
  muzzle-shaped wisps.
- **Never:** ears, tail, snout or paw shapes in the silhouette; fur-like texture;
  hair that grows or spreads; dog-like colour patches; fetch- or bone-themed
  items on the hero.
- **Check:** a playtester who doesn't know the twist reads the hero as a human
  child.

## 2. Mood & Atmosphere

[To be designed] — for each major game state (exploration, combat, victory,
defeat, menus — whichever this game has): the emotional target, lighting
character (time of day, colour temperature, contrast), 3–5 atmospheric
descriptors, and energy level. Each state must look distinct from the others.

## 3. Shape Language

[To be designed] — character silhouette philosophy (readable at thumbnail
size, one distinguishing trait per archetype), environment geometry, UI shape
grammar, and hero versus supporting shapes.

## 4. Color System

[To be designed] — a primary palette of 5–7 colours with their meaning in this
world, semantic colour usage, per-area colour temperature rules, the UI palette
and where it diverges, and colourblind safety: which semantic colours need a
shape, icon or sound backup.

## 5. Character Design Direction

[To be designed] — the player character's visual archetype, how players tell
enemies, NPCs and allies apart at a glance, expression and pose style, and how
much detail survives at game camera distance (LOD philosophy).

## 6. Environment Design Language

[To be designed] — architectural style and its tie to the world's culture,
texture philosophy (painted, PBR or stylised, and why), prop density rules per
area type, and environmental storytelling guidelines.

## 7. UI/HUD Visual Direction

[To be designed] — diegetic versus screen-space HUD, typography (personality,
weight, size hierarchy, minimum readable size), iconography style, UI animation
feel, and any art-direction versus readability conflict and how it was decided.

## 8. Asset Standards

[To be designed] — file formats, naming convention, texture resolution tiers,
LOD levels, export settings, and the engine's hard limits (poly budgets per
asset category, texture memory, material slots). Where an art preference and a
technical limit disagree, record both and the trade-off chosen.

## 9. Reference Direction

[To be designed] — 3–5 references (games, films, art styles or artists). For
each: the specific element to take from it, and what to avoid so the result
does not read as a copy.
