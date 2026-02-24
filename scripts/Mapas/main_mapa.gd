extends Node2D

@export_category("Objects")
@export var player: BasePlayer
@export var fade_transition: FadeTransition

var area_entered: String = ''

func _ready() -> void:
	fade_transition.transition_end.connect(_on_transition_finished)
	fade_transition.out()
	
func on_Enter_Sala_Faimisson_body_entered(body: Node2D) -> void:
	if (body.is_in_group('Player')):
		player.animation_player.play('Idle_Right')
		player.pause()
		area_entered = 'faimison'
		fade_transition.init()
		
func _on_enter_biblioteca_body_entered(body: Node2D) -> void:
	if (body.is_in_group('Player')):
		player.animation_player.play('Idle_Back')
		player.pause()
		area_entered = 'biblioteca'
		fade_transition.init()
		
func _on_transition_finished() -> void:
	if (area_entered == 'faimison'):
		Player_Tracking.spawn_pos = Vector2.ZERO
		Player_Tracking.spawn_facing = Vector2.RIGHT
		get_tree().change_scene_to_file('res://scenes/Mapas/Sala_Faimisson.tscn')
	elif (area_entered == 'biblioteca'):
		Player_Tracking.spawn_pos = Vector2.ZERO
		Player_Tracking.spawn_facing = Vector2.UP
		get_tree().change_scene_to_file('res://scenes/Mapas/Library/Biblioteca.tscn')


func _on_button_pressed() -> void:
	Player_Stats.gain_xp(100)
