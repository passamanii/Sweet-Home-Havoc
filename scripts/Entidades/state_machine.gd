extends Node

@export var initial_state: State

var states: Dictionary = {}
var curr_state: State

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_state_transitioned)
	
	if (initial_state):
		curr_state = initial_state
		curr_state.Enter()

func _physics_process(delta: float) -> void:
	if (curr_state):
		curr_state.Update(delta)

func on_state_transitioned(state: State, new_state_name: String):
	if (state != curr_state):
		return
		
	var new_state = states.get(new_state_name.to_lower())
	if (!new_state):
		return
		
	if (curr_state):
		curr_state.Exit();
		curr_state = new_state;
		curr_state.Enter();
		print(curr_state.name)
