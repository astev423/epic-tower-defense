# Epic Tower Defense
Simple tower defense game inspired by BTD5

# Game info

## Basic idea
Enemies spawn on the leftside of the map, they follow the dirt path until reaching the rightmost end of the path. If they reach
the end then they take away varying amount of your lives. Place towers and upgrade those towers to kill enemies. Get money for
more towers by killing enemies and passing waves.

## Controls
-Left mouse button can click on towers and upgrade them

-Right mouse button can click on towers to sell them for 1/2 their purchase price

-Spacebar to pause/unpause game

-Press esc to cancel action/unhighlight tower

## Towers
-Cannon: Solid all around, good dps per dollar, decent range, can deal with most enemies, deals blunt damage

-Crossbow: Slow to attack but deals big damage and has large range, deals piercing damage

-Machine gunner: General all purpose tower, more expensive than cannon but better dps and has some basic AOE mechanics, deals piercing damage

-Crystal: Extremely expensive but shoots a beam that extreme deals continuous damage to a single target after done charging, tier 3 does far more dps than other other tower but also costs far more, deals energy damage

-Flamethrower: Heavy AOE damage but very short radius, deals fire damage

-Rocket launcher: Medium AOE damage but large radius, deals explosive damage

# Design
-Important functions at the top, functions called by those functions near the bottom.

-Event driven design (_input), instead of using _process and polling

-CharBodies and Areas sometimes don't have a layer, only a mask, or vice versa, depending on if they
only need to scan or only need to be collided with

-Seperation of concerns, art goes in assets, stats and other non logic data does NOT go in code, instead
store it in a resource or in the editor, like define area connections in the editor, other node data
like sprites, etc. Instead code is only for pure game logic. Prefer empty entities and the logic
mostly contained within their components
