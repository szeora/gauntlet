extends PlayerState
class_name PlayerStateFall

# ==================================================================================================
# VARIABLES
# ==================================================================================================

@export var fall_gravity: float = 1.175
@export var coyote_time: float = 0.125
var coyote_timer: float = 0.0

@export var buffer_time: float = 0.125
var buffer_timer: float = 0.0

# ==================================================================================================
# METHODS
# ==================================================================================================

func init() -> void:
	pass

func enter() -> void:
	player.gravity_multiplier = fall_gravity
	if player.previous_state == jump:
		coyote_timer = 0
	else:
		coyote_timer = coyote_time
	pass

func exit() -> void:
	player.gravity_multiplier = 1.0
	pass

func process(delta: float) -> PlayerState:
	coyote_timer -= delta
	buffer_timer -= delta
	return next_state

func physics(_delta: float) -> PlayerState:
	if player.is_on_floor():
		if buffer_timer > 0:
			return jump
		return idle
	
	player.velocity.x = player.direction.x * player.move_speed
	return next_state

func handle_input(event: InputEvent) -> PlayerState:
	if event.is_action_pressed("jump"):
		if coyote_timer > 0:
			return jump
		else:
			buffer_timer = buffer_time
	return next_state
