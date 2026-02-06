extends Node

@export var initial_state: State

var curr_state: State
var states: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transitioned)
			
	if initial_state:
		initial_state.Enter()
		curr_state = initial_state
		
func _physics_process(delta: float) -> void:
	if curr_state:
		curr_state.Update(delta)

func on_child_transitioned(state: State, new_state_name: String) -> void:
	if state != curr_state:
		return

	var new_state: State = states.get(new_state_name.to_lower())
	if !new_state:
		return
		
	if curr_state:
		curr_state.Exit()
	
	new_state.Enter()
	curr_state = new_state
	
