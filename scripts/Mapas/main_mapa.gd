extends Node2D


var area_entered: String = ''

func _ready() -> void:
	
	$Menu_Transition.show()
	$Menu_Transition/AnimationPlayer.play("fade_out")
	
func on_Enter_Sala_Faimisson_body_entered(body: Node2D) -> void:

	if (body.is_in_group('Player')):
		$player/AnimationPlayer.play('Idle_Right')
		$player.set_physics_process(false)
		area_entered = 'faimison'
		$Menu_Transition.show()
		$Menu_Transition/Timer.start()
		$Menu_Transition/AnimationPlayer.play('fade_in')
		
func _on_enter_biblioteca_body_entered(body: Node2D) -> void:
	
	if (body.is_in_group('Player')):
		$player/AnimationPlayer.play('Idle_Back')
		$player.set_physics_process(false)
		area_entered = 'biblioteca'
		$Menu_Transition.show()
		$Menu_Transition/Timer.start()
		$Menu_Transition/AnimationPlayer.play('fade_in')
		
func _on_timer_timeout() -> void:
	
	if (area_entered == 'faimison'):
		Player_Tracking.spawn_pos = Vector2.ZERO
		Player_Tracking.spawn_facing = Vector2.RIGHT
		get_tree().change_scene_to_file('res://scenes/Mapas/Sala_Faimisson.tscn')
		
	elif (area_entered == 'biblioteca'):
		Player_Tracking.spawn_pos = Vector2.ZERO		
		Player_Tracking.spawn_facing = Vector2.UP
		get_tree().change_scene_to_file('res://scenes/Mapas/Biblioteca.tscn')


func _on_button_pressed() -> void:
	Player_Stats.gain_xp(100)
