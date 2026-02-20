extends Control

@export_category("Objects")
@export var pause_menu_canvas: CanvasLayer
@export var anim_player: AnimationPlayer

func _process(_delta: float) -> void:
	test_esc()
	
func resume() -> void:
	anim_player.play("Menu_Fade_Out")
	get_tree().paused = false
	
func pause() -> void:
	get_tree().paused = true
	pause_menu_canvas.show()
	anim_player.play('Menu_Fade_In')
	
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

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if (anim_name == "Menu_Fade_Out"):
		pause_menu_canvas.hide()
