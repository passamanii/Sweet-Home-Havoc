extends Node2D

@export_category("Objects")
@export var player: BasePlayer
@export var fade_transition: FadeTransition

var area_entered: String = ''

func _ready() -> void:
	fade_transition.transition_end.connect(_on_transition_end)
	player.animation_player.play('Idle_Right')
	fade_transition.out()

#ds
			
func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.is_in_group('Player')):
		area_entered = 'main_mapa'
		
		player.animation_player.play('Idle_Left')
		player.pause()
		fade_transition.init()
			

func _on_transition_end() -> void:
	if (area_entered == 'main_mapa'):
		Player_Tracking.spawn_pos = Vector2(4842.0, 1064.0)
		Player_Tracking.spawn_facing = Vector2.LEFT
		get_tree().change_scene_to_file("res://scenes/Mapas/Main_Mapa.tscn")


func _on_button_pressed() -> void:
	Player_Stats.gain_xp(10)
