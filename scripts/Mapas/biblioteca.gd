extends Node2D
var area_entered: String = ''

@export_category("Objects")
@export var player: BasePlayer
@export var fade_transition: FadeTransition
@export var locker_code: CanvasLayer

func _ready() -> void:
	fade_transition.transition_end.connect(_on_transition_end)
	fade_transition.out()

func _process(_delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.is_in_group('Player')):
		player.animation_player.play('Idle_Front')
		player.pause()
		area_entered = 'main_mapa'
		fade_transition.init()

func _on_transition_end() -> void:
	if (area_entered == 'main_mapa'):
		Player_Tracking.spawn_pos = Vector2(2407.0, -694)
		Player_Tracking.spawn_facing = Vector2.DOWN
		get_tree().change_scene_to_file("res://scenes/Mapas/Main_Mapa.tscn")

func _on_old_locker_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		locker_code.show()
		player.pause()
