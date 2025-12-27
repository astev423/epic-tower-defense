"""
-Add another enemy to work on waves

-Work on waves, don't save waves until the end as that will be tedious and I won't have much motivation, make at least
10 waves with good amount of enemies and varying spawn times between them for plains level before moving on

-Instead of hard coding paths, reference other nodes via Scene Unique Names

-Tower ideas, flamethrower (aoe, short range), missle launcher (aoe, longer range), crossbow (low fire, 
high damage), machine gun (low damage, high fire), sniper of doom (unlimited range, super high damage
, super high cost, low fire rate)

-Potential bug when two cannonballs both kill enemy giving double cash per kill, i think
bool in died signal fixed this

-Big refactor, particularly for managers, towers, and enemies, maybe try changing the monsters
from directly calling manager method, instead use signals, maybe split up tower manager

-Add more waves

-Work on UI, make start menu, let users exit map and go to main menu, add death screen that takes you back to main menu, and
in main menu itself let users click play then select map or see their stats (saved via godot saving), or red button for exit

-CPU particle fireworks when win map

-Add fast-forward button

-Add custom sound effects like hurt sound/death sound and add royalty free background music, maybe bossa nova

-Checkout popular plugins
"""
