extends Node2D

@onready var npc: CharacterBody2D = $NPC

@export_category("Objects")
@export var fade_transition: FadeTransition
@export var player: BasePlayer
@export var dungeon_hud: CanvasLayer
@export var waves_controller: Node

func _ready() -> void:
	Player_Tracking.player = player
	Game_Controller.player_alive = true
	player.animation_player.play("Idle_Front")
	fade_transition.out()
	waves_controller.won_dungeon_01.connect(_on_dungeon_finish)
	player.player_died.connect(_on_player_died)

func _on_player_died() -> void:
	# Desfazer tudo que ele ganhou e talvez uma tela de morte, ou so uma tela escurecendo e ele renascendo
	print("Não, se preocupe... você pode tentar denovo")
	if npc.dialog_info["current_branch_index"] == 1:
		npc.start_dialog()
		Player_Tracking.player.is_talking = true
	while Player_Tracking.player.is_talking == true:
		await get_tree().create_timer(0.1).timeout
	fade_transition.init()
	await fade_transition.timer.timeout
	get_tree().reload_current_scene()

func _on_dungeon_finish():
	player.pause()
	player.animation_player.play("Idle_Front")
	if npc.dialog_info["current_branch_index"] == 1:
		npc.dialog_info["current_branch_index"] = 2
		npc.start_dialog()
		Player_Tracking.player.is_talking = true
	elif npc.dialog_info["current_branch_index"] == 3:
		npc.start_dialog()
		Player_Tracking.player.is_talking = true
	while Player_Tracking.player.is_talking == true:
		await get_tree().create_timer(0.1).timeout
	fade_transition.transition_end.connect(_on_transition_end)
	fade_transition.init()
	dungeon_hud.hide()

func _on_transition_end():
	Player_Tracking.spawn_pos = Vector2(322, -420)
	Player_Tracking.spawn_facing = Vector2.DOWN
	get_tree().change_scene_to_file("res://scenes/Mapas/Library/Biblioteca.tscn")
