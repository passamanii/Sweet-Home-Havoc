extends Control

@onready var fade_transition: FadeTransition = $Fade_Transition

var button_type: String 

func _ready() -> void:
	fade_transition.transition_end.connect(_on_fade_end)
	fade_transition.out()
	
func _on_main_menu_pressed() -> void:
	button_type = 'main_menu'
	fade_transition.init()

func _on_fade_end():
	if button_type == 'main_menu':
		get_tree().change_scene_to_file("res://scenes/Menus/Main_Menu.tscn")
	
