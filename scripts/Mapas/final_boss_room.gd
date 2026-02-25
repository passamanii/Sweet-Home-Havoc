extends Node2D

@export var player: BasePlayer

func _ready() -> void:
	player.camera_2d.zoom = Vector2(0.45, 0.45)
