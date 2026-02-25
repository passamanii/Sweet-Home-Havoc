extends Control

@export_category("Objects")
@export var pause_menu_canvas: CanvasLayer
@export var anim_player: AnimationPlayer

func _process(_delta: float) -> void:
	test_esc()
	
func resume() -> void:
	Game_Controller.can_pause = false
	anim_player.play("Menu_Fade_Out")
	await anim_player.animation_finished
	pause_menu_canvas.hide()
	await get_tree().create_timer(0.5).timeout
	get_tree().paused = false
	Game_Controller.can_pause = true

func resume_and_change_scene() -> void:
	pause_menu_canvas.hide()
	get_tree().paused = false
	
func pause() -> void:
	Game_Controller.can_pause = false
	get_tree().paused = true
	anim_player.play('Menu_Fade_In')
	pause_menu_canvas.show()
	Game_Controller.can_pause = true
	
func test_esc() -> void:
	if Game_Controller.can_pause:
		if (Input.is_action_just_pressed('menu') and get_tree().paused == false):
			pause()
			
		elif (Input.is_action_just_pressed('menu') and get_tree().paused == true):
			resume()
	else:
		return
		
func _on_resume_pressed() -> void:
	resume()

func _on_options_pressed() -> void:
	resume_and_change_scene()
	get_tree().change_scene_to_file('res://scenes/Menus/Options.tscn')
	PlayerHud.hide()
	
func _on_main_menu_pressed() -> void:
	resume_and_change_scene()
	get_tree().change_scene_to_file('res://scenes/Menus/Main_Menu.tscn')
	PlayerHud.hide()
	
func _on_exit_game_pressed() -> void:
	get_tree().quit()

		
