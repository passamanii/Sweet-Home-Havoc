extends Node2D

@export_category("Objects")
@export var _player: CharacterBody2D
@export var _hud: CanvasLayer

func _ready():
	GameProgress.time_finished.connect(Callable(get_tree(), "change_scene_to_file").bind("res://scenes/game_over.tscn"))
	
	var cam: Camera2D = _player.camera
	
	_player.happiness_changed.connect(_hud.set_happiness)
	_player.health_changed.connect(_hud.set_health)
	
	cam.limit_left = -1702
	cam.limit_right = 2394
	cam.limit_top = -3031
	cam.limit_bottom = 650
	cam.zoom = Vector2(0.35, 0.35)


func _door_enter(body: Node2D, source: Area2D) -> void:
	if body.is_in_group("Player"):
		match source.name:
			"Prova":
				get_tree().change_scene_to_file("res://Scenes/Levels/final_test.tscn")
			"Cantina":
				get_tree().change_scene_to_file("res://Scenes/Levels/cantina.tscn")
			"Biblioteca":
				get_tree().change_scene_to_file("res://Scenes/Levels/study_map.tscn")
