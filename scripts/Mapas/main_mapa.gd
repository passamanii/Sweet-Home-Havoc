extends Node2D

var area_entered: String = ''

func _ready() -> void:
	
	$Menu_Transition.show()
	$Menu_Transition/AnimationPlayer.play("fade_out")
	
func on_Enter_Sala_Faimisson_body_entered(body: Node2D) -> void:

	if (body.is_in_group('Player')):
		
		$player.set_physics_process(false)
		area_entered = 'faimison'
		$Menu_Transition.show()
		$Menu_Transition/Timer.start()
		$Menu_Transition/AnimationPlayer.play('fade_in')
		
func _on_enter_biblioteca_body_entered(body: Node2D) -> void:
	
	if (body.is_in_group('Player')):
		
		$player.set_physics_process(false)
		area_entered = 'biblioteca'
		$Menu_Transition.show()
		$Menu_Transition/Timer.start()
		$Menu_Transition/AnimationPlayer.play('fade_in')
		
func _on_timer_timeout() -> void:
	
	if (area_entered == 'faimison'):
		
		Globals.spawn_pos = Vector2.ZERO
		Globals.spawn_facing = Vector2.RIGHT
		get_tree().change_scene_to_file('res://scenes/Mapas/Sala_Faimisson.tscn')
		
	elif (area_entered == 'biblioteca'):
		
		Globals.spawn_pos = Vector2.ZERO		
		Globals.spawn_facing = Vector2.UP
		get_tree().change_scene_to_file('res://scenes/Mapas/Biblioteca.tscn')
