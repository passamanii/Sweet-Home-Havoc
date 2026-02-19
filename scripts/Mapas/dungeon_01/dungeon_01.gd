extends Node2D

@export_category("Objects")
@export var fade_transition: FadeTransition
@export var player: BasePlayer

func _ready() -> void:
	player.animation_player.play("Idle_Front")
	fade_transition.out()
