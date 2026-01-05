extends Node2D

# When enemy clicked on, emit eventbus signal with type of enemy
# Managers will listen for that signal and disable all highlighted stuff when signal fires
# Stats displayer will read stats from resources for given type
# Stats displayer will also listen for signals, like if tower clicked on or esc pressed, and will hide
# when needed
