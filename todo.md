"""
-Add upgrade system for cannon, ensure cost, damage, range, etc is all correct

-Tower ideas, flamethrower (aoe, short range), missle launcher (aoe, longer range), crossbow (low fire, 
high damage), machine gun (low damage, high fire), sniper of doom (unlimited range, super high damage
, super high cost, low fire rate)

-Work on waves, don't save waves until the end as that will be tedious and I won't have much motivation, make at least
10 waves with good amount of enemies and varying spawn times between them for plains level before moving on

-Potential bug when two cannonballs both kill enemy giving double cash per kill

-Make tower system modular instead of hard coded, then add a bunch of different towers

-Make multiple waves per level, multiple levels per map, like btd5, show level count out of x at bottom
timer between waves, maybe store enemies in each wave in a resource,
also award user some money on each level they beat

-Let users sell their towers for half the purchase price

-Big refactor, particularly for managers, towers, and enemies, maybe try changing the monsters
from directly calling manager method, instead use signals, maybe split up tower manager

-Add more waves

-Work on UI, make start menu, let users exit map and go to main menu, add death screen that takes you back to main menu, and
in main menu itself let users click play then select map or see their stats (saved via godot saving), or red button for exit

-Also add background to UI, maybe some border and padding, make it look good

-CPU particle fireworks when win map

-Add fast-forward button

-Add custom sound effects like hurt sound/death sound and add royalty free background music, maybe bossa nova

-Checkout popular plugins
"""
