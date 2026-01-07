extends CanvasLayer

# ==================================================================================================
# VARIABLES
# ==================================================================================================

signal load_started
signal scene_ready(target_name: String, offset: Vector2)
signal load_finished

@onready var fade: Control = $Fade

# ==================================================================================================
# METHODS
# ==================================================================================================

func _ready() -> void:
	fade.visible = false
	await get_tree().process_frame
	load_finished.emit()
	pass

# ==================================================================================================
# OPERATIONS
# ==================================================================================================

func transition_scene(new_scene: String, target_area: String, player_offset: Vector2, dir: String) -> void:
	get_tree().paused = true
	fade.visible = true
	
	var fade_position: Vector2 = fade_direction(dir)
	
	load_started.emit()
	
	await fade_screen(fade_position, Vector2.ZERO)
	get_tree().change_scene_to_file(new_scene)
	await get_tree().scene_changed
	scene_ready.emit(target_area, player_offset)
	await fade_screen(Vector2.ZERO, -fade_position)
	
	fade.visible = false
	get_tree().paused = false
	
	load_finished.emit()
	pass

func fade_direction(d: String) -> Vector2:
	var position: Vector2 = Vector2(1280, 720)
	
	match d:
		"left":
			position *= Vector2(-1, 0)
		"right":
			position *= Vector2(1, 0)
		"up":
			position *= Vector2(0, -1)
		"down":
			position *= Vector2(0, 1)
	return position

func fade_screen(from: Vector2, to: Vector2) -> Signal:
	fade.position = from
	var tween: Tween = create_tween()
	tween.tween_property(fade, "position", to, 0.25)
	return tween.finished
