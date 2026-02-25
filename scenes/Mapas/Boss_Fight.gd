extends Node2D

@onready var interact_with: Interaction_With = $InteractWith

func _ready() -> void:
	interact_with.interact = _on_interact

func _on_interact():
	get_tree().change_scene_to_file('res://scenes/Mapas/final_boss_room_01.tscn')
	pass
