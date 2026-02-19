extends Node2D

@export_category("Objects")
@export var fade_transition: FadeTransition

func _ready() -> void:
	fade_transition.out()
