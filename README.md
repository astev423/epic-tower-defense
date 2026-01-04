# Epic Tower Defense
Simple tower defense game inspired by BTD5

# Controls
-Left mouse button can click on towers and upgrade them

-Right mouse button can click on towers to sell them for 1/2 their purchase price

-Spacebar to pause/unpause game

# Game info
## Towers
-Cannon: Solid all around, good dps per dollar, decent range, can deal with most enemies, deals blunt damage

-Crossbow: Slow to attack but deals massive damage and has large range, deals piercing damage

-Crystal: Extremely expensive but shoots a beam that extreme deals continuous damage to a single target after done charging, tier 3 does far more dps than other other tower but also costs far more, deals typeless damage

-Flamethrower: Heavy AOE damage but very short radius, deals fire damage

-Machine gunner: General all purpose tower, more expensive than cannon but better dps and has some basic AOE mechanics, deals piercing damage

-Rocket launcher: Medium AOE damage but large radius, deals explosive damage

## Monsters
-Weakling: Standard enemy, very weak, nothing special

-Fast weakling: Weakling but 4x faster

-Bubba: Big brown orc with medium health and is very slow

# Design
-Important functions at the top, functions called by those functions near the bottom.

-Event driven design (_input), instead of using _process and polling

-CharBodies and Areas sometimes don't have a layer, only a mask, or vice versa, depending on if they
only need to scan or only need to be collided with

-Seperation of concerns, art goes in assets, stats and other non logic data does NOT go in code, instead
store it in a resource or in the editor, like define area connections in the editor, other node data
like sprites, etc. Instead code is only for pure game logic. Prefer empty entities and the logic
mostly contained within their components
