@icon("res://Player/States/state_icon.svg")
extends Node
class_name PlayerState

# ==================================================================================================
# VARIABLES
# ==================================================================================================

var player: Player
var next_state: PlayerState

@onready var idle: PlayerStateIdle = %Idle
@onready var run: PlayerStateRun = %Run
@onready var jump: PlayerStateJump = %Jump
@onready var fall: PlayerStateFall = %Fall

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
