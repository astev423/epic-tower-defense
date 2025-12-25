extends Node2D

@onready var tower_placement_manager: Node2D = $"../TowerPlacementManager"
var current_tower_highlighted: Node2D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Allow upgrading towers while paused
	process_mode = Node.PROCESS_MODE_ALWAYS
	tower_placement_manager.connect("tower_placed", connect_to_new_tower)


func _process(delta) -> void:
	if Input.is_action_just_pressed("esc"):
		unhighlight_tower()


func connect_to_new_tower(new_tower) -> void:
	new_tower.connect("tower_clicked_on", highlight_tower_clicked_on)


func highlight_tower_clicked_on(tower) -> void:
	# Unhighlight previous tower if it was highlighted and we clicked on a NEW tower
	if current_tower_highlighted != null and current_tower_highlighted != tower:
		current_tower_highlighted.attack_range_display.visible = false

	if tower.attack_range_display.visible:
		tower.attack_range_display.visible = false
		current_tower_highlighted = null
	else:
		tower.attack_range_display.visible = true
		current_tower_highlighted = tower


func unhighlight_tower() -> void:
	# Can't set fields on a null instance
	if current_tower_highlighted == null:
		return

	current_tower_highlighted.attack_range_display.visible = false
	current_tower_highlighted = null
