extends Node2D

@export var player: BasePlayer
@export var fade_transition: FadeTransition

func _ready() -> void:
	fade_transition.out_white()
	player.camera_2d.zoom = Vector2(0.45, 0.45)
