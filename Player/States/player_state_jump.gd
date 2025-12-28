extends PlayerState
class_name PlayerStateJump

# ==================================================================================================
# VARIABLES
# ==================================================================================================

@export var jump_speed: float = 500.0

# ==================================================================================================
# METHODS
# ==================================================================================================

func init() -> void:
	pass

func enter() -> void:
	player.velocity.y = -jump_speed
	pass

func exit() -> void:
	pass

func process(_delta: float) -> PlayerState:
	return next_state

func physics(_delta: float) -> PlayerState:
	if player.is_on_floor():
		return idle
	elif player.velocity.y >= 0:
		return fall
	
	player.velocity.x = player.direction.x * player.move_speed
	return next_state

func handle_input(event: InputEvent) -> PlayerState:
	if event.is_action_released("jump"):
		player.velocity.y *= 0.5
		return fall
	return next_state
