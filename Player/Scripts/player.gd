extends CharacterBody2D
class_name Player

# ==================================================================================================
# VARIABLES
# ==================================================================================================

var states: Array[PlayerState]
var current_state: PlayerState: 
	get: return states.front()
var previous_state: PlayerState:
	get: return states[1]

var direction: Vector2 = Vector2.ZERO
var gravity: float = 980

# ==================================================================================================
# METHODS
# ==================================================================================================

func _ready() -> void:
	initialize_states()
	pass

func _process(delta: float) -> void:
	update_direction()
	change_state(current_state.process(delta))
	pass

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	move_and_slide()
	change_state(current_state.physics(delta))
	pass

func _unhandled_input(event: InputEvent) -> void:
	change_state(current_state.handle_input(event))
	pass

# ==================================================================================================
# OPERATIONS
# ==================================================================================================

func initialize_states() -> void:
	states = []
	
	for c in $Machine.get_children():
		if c is PlayerState:
			states.append(c)
			c.player = self
		pass
	
	if states.size() == 0:
		return
	
	for state in states:
		state.init()
		pass
	
	change_state(current_state)
	current_state.enter()
	pass

func change_state(new_state: PlayerState) -> void:
	if new_state == null:
		return
	elif new_state == current_state:
		return
	
	if current_state:
		current_state.exit()
		pass
	
	states.push_front(new_state)
	current_state.enter()
	states.resize(3)
	pass

func update_direction() -> void:
	var previous_direction: Vector2 = direction
	direction = Input.get_vector("left", "right", "up", "down")
	pass
