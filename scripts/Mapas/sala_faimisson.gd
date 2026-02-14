extends Node2D

var area_entered: String = ''

func _ready() -> void:
	
	$Fade_Transition.show()
	$Fade_Transition/AnimationPlayer.play('fade_out')
	$Player/AnimationPlayer.play('Idle_Right')
	
func _on_area_2d_body_entered(body: Node2D) -> void:

	if (body.is_in_group('Player')):
			
		$Player.set_physics_process(false)
		area_entered = 'main_mapa'
		$Fade_Transition.show()
		$Fade_Transition/Timer.start()
		$Fade_Transition/AnimationPlayer.play('fade_in')
			

func _on_timer_timeout() -> void:
	
	if (area_entered == 'main_mapa'):
		
		get_tree().change_scene_to_file("res://scenes/Mapas/Main_Mapa.tscn")
