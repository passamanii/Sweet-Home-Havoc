extends Node2D

@export_category("Objects")
@export var fade_transition: FadeTransition
@export var player: BasePlayer
@export var dungeon_hud: CanvasLayer
@export var waves_controller: Node

func _ready() -> void:
	player.animation_player.play("Idle_Front")
	fade_transition.out()
	waves_controller.finished_dungeon_01.connect(_on_dungeon_finish)

func _on_dungeon_finish(win: bool):
	if win:
		player.pause()
		player.animation_player.play("Idle_Front")
		fade_transition.transition_end.connect(_on_transition_end)
		fade_transition.init()
		dungeon_hud.hide()

func _on_transition_end():
	Player_Tracking.spawn_pos = Vector2(322, -420)
	Player_Tracking.spawn_facing = Vector2.DOWN
	get_tree().change_scene_to_file("res://scenes/Mapas/Library/Biblioteca.tscn")
