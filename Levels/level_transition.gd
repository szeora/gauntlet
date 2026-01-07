@tool
@icon("res://Sundry/Icons/level_transition.svg")
extends Node2D
class_name LevelTransition

# ==================================================================================================
# VARIABLES
# ==================================================================================================

enum SIDE {LEFT, RIGHT, TOP, BOTTOM}

@export_range(2, 12, 1, "or_greater") var size: int = 2:
	set(value):
		size = value
		apply_area()

@export var location: SIDE = SIDE.LEFT:
	set(value):
		location = value
		apply_area()

@export_file("*.tscn") var target_level: String = ""
@export var target_area: String = "Transition"

@onready var area: Area2D = $Area

# ==================================================================================================
# METHODS
# ==================================================================================================

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	SceneManager.scene_ready.connect(_scene_ready)
	SceneManager.load_finished.connect(_load_finished)
	pass

# ==================================================================================================
# OPERATIONS
# ==================================================================================================

func apply_area() -> void:
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

func _player_entered(_n: Node2D) -> void:
	SceneManager.transition_scene(target_level, target_area, get_offset(_n), get_direction())
	pass

func _scene_ready(target_name: String, offset: Vector2) -> void:
	if target_name == name:
		var player: Node = get_tree().get_first_node_in_group("Player")
		player.global_position = global_position + offset
	pass

func _load_finished() -> void:
	area.monitoring = false
	area.body_entered.connect(_player_entered)
	await get_tree().physics_frame
	await get_tree().physics_frame
	area.monitoring = true
	pass

func get_offset(player: Node2D) -> Vector2:
	var offset: Vector2 = Vector2.ZERO
	var player_position: Vector2 = player.global_position
	
	if location == SIDE.LEFT or location == SIDE.RIGHT:
		offset.y = player_position.y - self.global_position.y
		if location == SIDE.LEFT:
			offset.x = -18
		else:
			offset.x = 18
	else:
		offset.x = player.position.x - self.global_position.x
		if location == SIDE.TOP:
			offset.y = -2
		else:
			offset.y = 66
	return offset

func get_direction() -> String:
	match location:
		SIDE.LEFT:
			return "left"
		SIDE.RIGHT:
			return "right"
		SIDE.TOP:
			return "up"
		_:
			return "down"
