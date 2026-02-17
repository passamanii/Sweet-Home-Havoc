extends Control

func _process(_delta: float) -> void:
	
	test_esc()
	
func resume() -> void:
	$AnimationPlayer.play("Menu_Fade_Out")
	get_tree().paused = false
	visible = false
	
func pause() -> void:
	
	get_tree().paused = true
	$AnimationPlayer.play('Menu_Fade_In')
	visible = true
	
func test_esc() -> void:
	
	if (Input.is_action_just_pressed('Menu') and get_tree().paused == false):
		pause()
		
	elif (Input.is_action_just_pressed('Menu') and get_tree().paused == true):
		resume()		
		

func _on_resume_pressed() -> void:
	
	resume()


func _on_options_pressed() -> void:
	
	resume()
	get_tree().change_scene_to_file('res://scenes/Menus/Options.tscn')


func _on_main_menu_pressed() -> void:
	
	resume()
	get_tree().change_scene_to_file('res://scenes/Menus/Main_Menu.tscn')
	

func _on_exit_game_pressed() -> void:
	
	get_tree().quit()
