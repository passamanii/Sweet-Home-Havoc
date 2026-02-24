class_name HeartUI extends Control

@onready var heart_sprite: Sprite2D = $Sprite2D

var value: int = 0:
	set(_value):
		value = _value
		update_sprite()

func update_sprite() -> void:
	heart_sprite.frame = value
