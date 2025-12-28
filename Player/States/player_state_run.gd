extends PlayerState
class_name PlayerStateRun

# ==================================================================================================
# VARIABLES
# ==================================================================================================



# ==================================================================================================
# METHODS
# ==================================================================================================

func init() -> void:
	pass

func enter() -> void:
	player.animation.play("run")
	pass

func exit() -> void:
	pass

func process(_delta: float) -> PlayerState:
	if player.direction.x == 0:
		return idle
	elif player.direction.y > 0.5:
		return crouch
	return next_state

func physics(_delta: float) -> PlayerState:
	player.velocity.x = player.direction.x * player.move_speed
	if not player.is_on_floor():
		return fall
	return next_state

func handle_input(event: InputEvent) -> PlayerState:
	if event.is_action_pressed("jump"):
		return jump
	return next_state
