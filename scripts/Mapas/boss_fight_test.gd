extends Node2D

@export var boss: Faimisson2Head
@export var fade_transition: FadeTransition

func _ready() -> void:
	boss.get_child(0).killed_faimisson.connect(_on_killed_faimisson)

func _on_killed_faimisson() -> void:
	fade_transition.transition_end.connect(_on_transition_end)
	fade_transition.init()

func _on_transition_end() -> void:
	get_tree().change_scene_to_file("res://scenes/Menus/Main_Menu.tscn")
