"""
-Make upgrade manager control which tower displays range, only one tower can display range at a time,
if user presses esc then it removes the range highlight, also allow upgrading when paused

-Potential bug when two cannonballs both kill enemy giving double cash per kill

-Make tower system modular instead of hard coded, then add a bunch of different towers

-Make multiple waves per level, multiple levels per map, like btd5, show level count out of x at bottom
timer between waves, maybe store enemies in each wave in a resource,
also award user some money on each level they beat

-Let users sell their towers for half the purchase price

-Big refactor, particularly for managers, towers, and enemies, maybe try changing the monsters
from directly calling manager method, instead use signals, maybe split up tower manager

-CPU particle fireworks when win map

-Add fast-forward button

-Checkout popular plugins
"""
