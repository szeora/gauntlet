extends PointLight2D
class_name LightFlicker

# ==================================================================================================
# VARIABLES
# ==================================================================================================

@export var flicker_intensity: float = 0.25
@export var flicker_frequency: float = 0.1
var original_energy: float = 1.0

# ==================================================================================================
# METHODS
# ==================================================================================================

func _ready() -> void:
	original_energy = energy
	flicker()
	pass

# ==================================================================================================
# OPERATIONS
# ==================================================================================================

func flicker() -> void:
	var new_value: float = randf_range(-0.5, 0.5) * flicker_intensity
	energy = original_energy + new_value
	await get_tree().create_timer(
		flicker_frequency + randf_range(flicker_frequency * -0.25, flicker_frequency * 0.25)
		).timeout
	flicker()
	pass
