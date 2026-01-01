## Epic Tower Defense
Simple tower defense game inspired by BTD5

## Controls
-Left mouse button can click on towers and upgrade them

-Right mouse button can click on towers to sell them for 1/2 their purchase price

-Spacebar to pause/unpause game

## Design
-Important functions at the top, functions called by those functions near the bottom.

-Event driven design (_input), instead of using _process and polling

-CharBodies and Areas sometimes don't have a layer, only a mask, or vice versa, depending on if they
only need to scan or only need to be collided with
