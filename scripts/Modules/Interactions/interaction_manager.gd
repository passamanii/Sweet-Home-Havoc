extends Node2D

@onready var player = get_tree().get_first_node_in_group('Player')
@onready var label: Label = $Label

const base_text: String = '[E] to '

var active_areas: Array = []
var can_interact: bool = true


func _process(_delta: float) -> void:
	process_label()
	
func process_label():
	if active_areas.size() > 0 and can_interact:
		active_areas.sort_custom(_sort_by_distance_to_player)
		label.text = base_text + active_areas[0].action
		label.global_position = active_areas[0].global_position
		label.global_position.y -= 144
		label.global_position.x -= label.size.x / 2
		label.show()
	else:
		label.hide()
		
func _sort_by_distance_to_player(area1, area2):
	var area1_to_player: Vector2 = player.global_position.distance_to(area1.global_position)
	var area2_to_player: Vector2 = player.global_position.distance_to(area2.global_position)
	return area1_to_player < area2_to_player
	
func register_area(area: Interaction_With):
	active_areas.push_back(area)
	
func unregister_area(area: Interaction_With):
	var index := active_areas.find(area)
	if index != -1:
		active_areas.remove_at(index)
		
func _input(_event):
	if Input.is_action_just_pressed("interact") and can_interact:
		if active_areas.size() > 0:
			can_interact = false
			label.hide()
				
			await active_areas[0].interact.call()
				
			can_interact = true
	
		
	
