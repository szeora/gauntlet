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
	pass

func exit() -> void:
	pass

func process(_delta: float) -> PlayerState:
	return next_state

func physics(_delta: float) -> PlayerState:
	return next_state

func handle_input(_event: InputEvent) -> PlayerState:
	return next_state
