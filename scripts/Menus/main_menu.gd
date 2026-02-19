extends Control
var button_type: String = ''

@export_category("Objects")
@export var fade_transition: FadeTransition

func _ready() -> void:
	fade_transition.transition_end.connect(_on_transition_finished)
	fade_transition.out()
	
func _on_start_pressed() -> void:
	button_type = 'start'
	fade_transition.init()
	
func _on_options_pressed() -> void:
	button_type = 'options'
	
func _on_collectibles_pressed() -> void:
	button_type = 'collectibles'
	
func _on_exit_pressed() -> void:
	var maestro = get_tree()
	maestro.quit()

func _on_transition_finished() -> void:
	if (button_type == 'start'):
		get_tree().change_scene_to_file("res://scenes/Mapas/Main_Mapa.tscn")
	elif (button_type == 'options'):
		get_tree().change_scene_to_file("res://scenes/Menus/Options.tscn")
	elif (button_type == 'collectibles'):
		get_tree().change_scene_to_file('res://scenes/Menus/Collectibles.tscn')
