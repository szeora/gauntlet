extends PlayerState
class_name PlayerStateIdle

# ==================================================================================================
# VARIABLES
# ==================================================================================================



# ==================================================================================================
# METHODS
# ==================================================================================================

func init() -> void:
	pass

func enter() -> void:
	pass

func exit() -> void:
	pass

func process(_delta: float) -> PlayerState:
	if player.direction.x != 0:
		return run
	return next_state

func physics(_delta: float) -> PlayerState:
	player.velocity.x = 0
	if player.is_on_floor() == false:
		return fall
	return next_state

func handle_input(event: InputEvent) -> PlayerState:
	if event.is_action_pressed("jump"):
		return jump
	return next_state
