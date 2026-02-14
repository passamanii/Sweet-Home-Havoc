extends Node2D

var button_type: String = ''

func _ready() -> void:
	
	$Menu_Transition.show()
	$Menu_Transition/Fade_Timer.start()
	$Menu_Transition/AnimationPlayer.play('fade_out')
	
func _on_start_pressed() -> void:

	button_type = 'start'
	$Menu_Transition.show()
	$Menu_Transition/Fade_Timer.start()
	$Menu_Transition/AnimationPlayer.play('fade_in')
	
func _on_options_pressed() -> void:
	
	button_type = 'options'
	$Menu_Transition.show()
	$Menu_Transition/Fade_Timer.start()
	$Menu_Transition/AnimationPlayer.play('fade_in')
	
func _on_collectibles_pressed() -> void:
	
	button_type = 'collectibles'
	$Menu_Transition.show()
	$Menu_Transition/Fade_Timer.start()
	$Menu_Transition/AnimationPlayer.play('fade_in')
	
func _on_exit_pressed() -> void:
	
	var maestro = get_tree()
	maestro.quit()

func _on_fade_timer_timeout() -> void:
	
	if (button_type == ''):
		
		$Menu_Transition.hide()
		
	elif (button_type == 'start'):
		
		get_tree().change_scene_to_file("res://scenes/Mapas/Main_Mapa.tscn")
		
	elif (button_type == 'options'):
		
		get_tree().change_scene_to_file("res://scenes/Menus/Options.tscn")
		
	elif (button_type == 'collectibles'):
		
		get_tree().change_scene_to_file('res://scenes/Menus/Collectibles.tscn')
