extends Node2D

func _ready() -> void:
	GameProgress.pause()
	
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/level_base.tscn")

func _exit_tree() -> void:
	GameProgress.resume()
