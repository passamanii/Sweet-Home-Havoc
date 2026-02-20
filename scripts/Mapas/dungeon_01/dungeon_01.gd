extends Node2D

@export_category("Objects")
@export var fade_transition: FadeTransition
@export var player: BasePlayer
@export var dungeon_hud: CanvasLayer
@export var waves_controller: Node

func _ready() -> void:
	Game_Controller.player_alive = true
	player.animation_player.play("Idle_Front")
	fade_transition.out()
	waves_controller.won_dungeon_01.connect(_on_dungeon_finish)
	player.player_died.connect(_on_player_died)

func _on_player_died() -> void:
	# Desfazer tudo que ele ganhou e talvez uma tela de morte, ou so uma tela escurecendo e ele renascendo
	print("Não, se preocupe... você pode tentar denovo")
	fade_transition.init()
	await fade_transition.timer.timeout
	get_tree().reload_current_scene()

func _on_dungeon_finish():
		player.pause()
		player.animation_player.play("Idle_Front")
		fade_transition.transition_end.connect(_on_transition_end)
		fade_transition.init()
		dungeon_hud.hide()

func _on_transition_end():
	Player_Tracking.spawn_pos = Vector2(322, -420)
	Player_Tracking.spawn_facing = Vector2.DOWN
	get_tree().change_scene_to_file("res://scenes/Mapas/Library/Biblioteca.tscn")
