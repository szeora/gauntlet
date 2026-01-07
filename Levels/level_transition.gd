@tool
@icon("res://Sundry/Icons/level_transition.svg")
extends Node
class_name LevelTransition

# ==================================================================================================
# VARIABLES
# ==================================================================================================

enum SIDE {LEFT, RIGHT, TOP, BOTTOM}

@export_range(2, 12, 1, "or_greater") var size: int = 2:
	set(value):
		size = value
		apply_area_settings()

@export var location: SIDE = SIDE.LEFT:
	set(value):
		location = value
		apply_area_settings()

@export_file("*.tscn") var target_level: String = ""
@export var target_area: String = "Transition"

@onready var area: Area2D = $Area

# ==================================================================================================
# METHODS
# ==================================================================================================

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	area.body_entered.connect(_on_player_entered)
	pass

# ==================================================================================================
# OPERATIONS
# ==================================================================================================

func apply_area_settings() -> void:
	area = get_node_or_null("Area")
	
	if not area:
		return
	
	if location == SIDE.LEFT or location == SIDE.RIGHT:
		area.scale.y = size
		if location == SIDE.LEFT:
			area.scale.x = -1
		else:
			area.scale.x = 1
	else:
		area.scale.x = size
		if location == SIDE.TOP:
			area.scale.y = 1
		else:
			area.scale.y = -1
	pass

func _on_player_entered(_n: Node2D) -> void:
	SceneManager.transition_scene(target_level, target_area, Vector2.ZERO, "left")
	pass
