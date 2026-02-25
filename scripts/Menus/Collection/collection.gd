extends Control

@onready var fade_transition: FadeTransition = $CanvasLayer/Fade_Transition
var button_type: String

func _ready() -> void:
	fade_transition.transition_end.connect(_on_transition_finished)

func _on_main_menu_pressed() -> void:
	button_type = 'main_menu'

func _on_transition_finished():
	if button_type == 'main_menu':
		get_tree().change_scene_to_file("res://scenes/Menus/Main_Menu.tscn")
 
