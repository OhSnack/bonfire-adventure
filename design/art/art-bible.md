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

Each state has a fixed lighting identity: its contrast, light direction and
energy. The region sets the hue family, and the colour stage (Section 4) sets how
saturated and warm it is. So the same state looks the same everywhere, just more
alive later.

| State | Emotional target | Lighting | Descriptors | Energy | Mood carrier |
|---|---|---|---|---|---|
| Room exploration and door choice | Quiet curiosity, a little lonely | The region's hue family, soft and low contrast, top-down ambient light. Doors are the brightest shapes. | hushed, drifting, dusty, expectant | Low | Spirit wisps leaking through door gaps |
| Card combat | Focused and in control | The region's hues pushed into a dimmed backdrop, with high contrast in front and a side key light on the fighters | clear, tense, grounded, staged | Medium | A darkened backdrop so the fighters and icons stand forward |
| Elite or boss fight | Awe and pressure | The region's colour pushed hard, with strong rim light behind the enemy. In later regions the darker world makes the hero's warmth stand out more. | towering, heavy, charged, dramatic | High | The enemy's back-light; vignette at the screen edges |
| Events and NPCs | Strange, intimate, uncertain | Single-source pools of light (a lantern, a candle) with violet ambient | uncanny, close, secretive, tender | Low–medium | One local light the scene is gathered around |
| Haven (home bonfire) | Safety and belonging | The warmest place in the game. Bonfire light from below, soft falloff. | cosy, gathered, flickering, safe | Low | The bonfire, plus residents lit by it |
| Memory moment | Bittersweet recognition | A gold glow blooms from the centre and the world briefly fades back | luminous, still, aching, gentle | Low, then a soft swell | A colour "breath" that adds the new stage |
| Final approach and the Angel fight | Solemn resolve: small, but not alone | The deepest, coolest and darkest world in the game, rich indigo and violet, never grey. The hero and companions are the main warm light. | vast, deep, quiet, luminous, resolute | High, but held | A warm group of hero and companions against a cold, beautiful dark |
| Victory and run end | Relief, quiet pride | Warm amber wash, raised overall brightness | exhaling, warm, earned, open | Medium | Companions glowing brighter around the hero |
| Death and defeat | Sad but held, never graphic | Colour drains toward Ash and Slate. Light fades, never cuts to black. | fading, soft, sorrowful, gentle | Very low | The companions' flames dimming last |
| Menus | Calm invitation | A dim haven-style backdrop with a single bonfire glow | still, warm-edged, simple, waiting | Low | The bonfire ember idling |

**Gentle death:** defeat never shows breaking bones, scattering or violence
(anti-pillar: not graphic). The hero settles and the light fades.

## 3. Shape Language

**Silhouette philosophy.** Rounded shapes mean friend, angular shapes mean
threat. Each archetype has one trait that still reads at phone thumbnail size
(about 48 px tall).

| Archetype | Base shape | Distinguishing trait |
|---|---|---|
| Hero | Round. A big skull on a small body (child proportions, about 2.5 heads tall) | His fixed crown of hair locks (Section 1, principle 3) |
| Nerlings | Teardrop with the point facing up | The flame tip, with the family glyph (Section 4) in the core |
| Enemies (e.g. Hellhound) | Angular, sharp, heavy at the front | One exaggerated feature. Hellhound: a jagged ridge of flame along its spine. |
| NPC residents | Stable rectangles, tall or wide | One prop each: the merchant's pack, the fortune teller's veil |

The Hellhound is angular and spiky. The hero stays round and smooth, with no
ears, snout or tail (Section 1, dog-clue constraint), so the two never share a
silhouette.

**Isometric rooms.** A 2:1 isometric grid with soft-cornered blocks. Floors are
low contrast, walls are darker, and door arches are the strongest shapes in the
room, so the eye goes to the next choice first (Pillar 1).

**UI shape grammar**
- **Cards:** rounded rectangles, because they belong to the player.
- **Player and ally info** (companion charge rings, block): circles and shields.
- **Enemy intents:** angular plates; an attack intent sits on a diamond.
- **Statuses:** one fixed glyph each. Ignite is a jagged three-tongue flame, Weak
  a cracked chevron pointing down, block a shield.
- **No skull icons** for danger or death: the hero is a skeleton, and a skull
  would make him read as a threat.

**Door symbols.** A door answers two questions, "what kind of room?" and "which
Nerling family?", with two separate shapes.
- **Encounter type is shown by a large badge's outline:** a round badge with
  crossed blades for a regular fight, a spiked crown for an elite, a large
  horned double ring for a boss, a lantern for an event and a coin for the
  merchant. Badges are neutral Ash Bone, so the type reads from shape alone.
- **The Nerling family is shown by a small round medallion attached to the
  badge's edge**, holding the family glyph (Section 4) in the family colour. It
  is required on elites and optional elsewhere. A door with no family has no
  medallion; a door with two families shows two side by side. When every path is
  an elite, the badges match and the medallions are what the player compares.
- **Type and family never overlap**, both read in greyscale, and neither relies
  on colour alone.
- **In the room,** the scent wisp drifting from the door gap forms the
  medallion (Section 1). The door arch may glow faintly in the family colour,
  but only as an extra cue.
- **Exact placement and size** are set in Section 7 or the door UX spec after a
  phone-size mockup. A medallion at 60% of a 48 dp badge gives a glyph of about
  24 px, below the 29 px target, so size must be tested.
- **On Hades:** we take its clarity (a door that previews its reward), not its
  icon designs. Every badge and glyph is original.

**Hero versus supporting shapes.** The hero is the only small, round,
high-value silhouette with a rim light. Supporting characters sit at lower
contrast. Nerlings are the exception: they are the brightest shapes on the
player's side (Section 1, principle 2).

## 4. Color System

All hex values are provisional starting points, to be checked in mockups on
target phones.

**Primary palette**

| Name | Hex | Meaning |
|---|---|---|
| Ash Bone | #CFC8BE | The hero's starting bones; loss and absence |
| Dusk Slate | #2E3446 | Shadow and the world's base; the spirit world at rest |
| Spirit Teal | #6FD6D0 | Soul-light, scent wisps, perception |
| Hearth Amber | #F2B35E | Life returning, home, the haven |
| Memory Gold | #FFE3A3 | Memory moments only (rare, so it stays special) |
| Night Violet | #5B4A8C | Mystery, events; the anchor colour for the endgame |
| Ember Red | #FF5A1F | Harmful fire: Ignite and danger |

**Semantic colours.** These are fixed in every region and every stage
(Section 1, principle 1).

**How effect colours relate to the base palette.** Semantic colours are their
own fixed set. They are chosen to stand apart from the world palette, not taken
from it, so a status never blends into a background, a region or a colour stage.

| Meaning | Colour | Glyph |
|---|---|---|
| Ignite | #FF5A1F | Jagged three-tongue flame plus a stack number |
| Weak | #A08CC8 | Cracked chevron pointing down |
| Block | #7FA8D9 | Shield plus a number |
| Attack intent | #E8384F | Blade on a diamond plate plus damage number |
| Healing | #7DDB8A | Plus sign and a "+" on the number |
| Sparks | #FFF1A8 | Four-point star |
| Embers | #FF9A4A | Rounded coal (UI and haven only, never in combat) |
| Ember family | #FF7A3D | Single curled flame with a hollow eye; no flicker |
| Tide family | #3FA7E0 | Single wave crest with a flat base |
| Mist family | #C9C3EE | Fog bars: three thick, rounded horizontal bars, staggered left and right |
| Root family | #6BBF59 | Branching root, three roots pointing down |
| Chaos family | Core #4A1E6B, ring #D94FD1 | Filled orb with a tilted orbit ring |

Family glyphs are to be confirmed in a 24 px greyscale mockup, side by side.

**Keeping Ignite apart from the warm "life" colours.** Ignite is hot, fully
saturated red-orange with hard, jagged edges and a flicker. Life warmth (Hearth
Amber, Memory Gold) is lighter, softer yellow-amber, with round glows and no
flicker. Ignite only appears on combatants and icons; life warmth only in light,
the world and the hero. Embers are rounded and never appear in combat.

**New effects rule.** Every new status or effect gets a colour and a glyph that
differ from every row in the table above in both hue and outline. It is checked
against the colourblind table before it is used. Stun, Haunt and Linger are
named in the concept but not yet designed; they, and any later effect such as
poison, are added here once their mechanics are designed. *Known limit:* green
is already taken by healing and Root, so a future poison needs a different hue
(for example a sickly yellow-olive, an example only) or a very different glyph.

**Region palettes.** Each region chooses its hue family, shadow colour and one
accent. The memory stage then sets how saturated and warm those are. The regions
are not decided yet; the current concept's placeholder bosses are a great beast
of the wilds, a mother of night and a forge-lord. Each region fills in this
template:

| Field | What it sets |
|---|---|
| Hue family | The two or three main hues for ground, walls and sky |
| Shadow colour | The colour of shadows, usually the opposite temperature to the hue family |
| Accent | One small contrasting colour for points of interest |

*Examples only, not decisions:*

| Example region | Hue family | Shadow | Accent |
|---|---|---|---|
| Aquatic (cool) | Teal, sea-blue, kelp green | Deep navy #1E2A4A | Pale coral #F2A08C |
| Desert (warm) | Ochre, sand, dusty gold | Cool violet #4A3F6B | Turquoise #4FC1B5 |

**Rule for shared hues (all regions).** When a region's hues overlap a semantic
or companion colour, the region's version is darker and less saturated, and the
semantic colour keeps its dark outline and glyph. In a warm region, the ground
leans yellow-ochre, the shadows lean cool, and life warmth is shown as light
(glows, rim light) rather than paint. That leaves saturated red-orange for
Ignite alone. In a cool region, the backdrop blues stay darker and greyer than
Tide and block.

**Colour stages.** Stages scale saturation and warmth within each region's own
hues. They never change which hues a region uses.

| Stage | Trigger | World saturation | Changes |
|---|---|---|---|
| 0 Ashen | Start | about 35% | The region's hues washed out; the hero is grey-blue bone with ash hair |
| 1 Kindled | First memories | about 55% | Amber enters lamps and the haven; bones begin to warm |
| 2 Warming | Mid story | about 75% | The region's hue family shows fully; the hair warms |
| 3 Alive | Late story | 100% | Warm rim light; Memory Gold accents |

**Never changes:** semantic colours, intent and door icons, UI text, Nerlings
(always at full warmth), and the hero's shape. The colour grade sits on a
separate world layer that never touches the combat icons or UI. Implementing
that is for technical-artist.

**Endgame brightness rule.** On the way to the Angel of Death (the final
battle), each region is darker and cooler than the one before, ending in deep
indigo and Night Violet. Only brightness falls; saturation never drops below the
current stage, and the world never turns grey. The hero and companions are
exempt: they keep their own light and keep warming, so the final battle is warm
light against a cold, rich dark.

**UI palette.** The UI uses Dusk Slate panels with Ash Bone text and Hearth
Amber for highlights and selection. It does not follow the regions or stages;
only the frame accents warm a little.

**Colourblind safety**

| Pair at risk | Backup |
|---|---|
| Attack red vs heal and Root green | Blade/diamond vs plus/root; "−" vs "+" on numbers |
| Ignite vs Ember family | Jagged three-tongue flame on enemies vs single curled flame on the ally side |
| Tide vs block vs Mist | Wave crest vs shield vs fog bars |
| Weak vs Mist | Chevron vs fog bars; Weak only appears as a status |
| Mist vs Chaos | Straight stacked bars vs filled orb with ring |
| Root vs heal | Branching root vs plus sign |
| Chaos vs Night Violet backdrops | The magenta ring adds contrast in brightness |
| Sparks vs Memory Gold | Star icon vs full-scene glow |

Every semantic colour has a matching glyph, so colour is never the only signal.

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
