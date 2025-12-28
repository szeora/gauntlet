extends PlayerState
class_name PlayerStateCrouch

# ==================================================================================================
# VARIABLES
# ==================================================================================================

@export var deceleration_rate: float = 8.25

# ==================================================================================================
# METHODS
# ==================================================================================================

func init() -> void:
	pass

func enter() -> void:
	player.animation.play("crouch")
	player.collision.disabled = true
	player.duck.disabled = false
	pass

func exit() -> void:
	player.collision.disabled = false
	player.duck.disabled = true
	player.sensor.enabled = false
	pass

func process(_delta: float) -> PlayerState:
	if player.direction.y <= 0.5:
		return idle
	return next_state

func physics(delta: float) -> PlayerState:
	player.velocity.x -= player.velocity.x * deceleration_rate * delta
	if not player.is_on_floor():
		return fall
	return next_state

func handle_input(event: InputEvent) -> PlayerState:
	if event.is_action_pressed("jump"):
		player.sensor.force_shapecast_update()
		if player.sensor.is_colliding():
			player.position.y += 5
			return fall
		return jump
	return next_state
