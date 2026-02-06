extends Node
class_name State

@warning_ignore("unused_signal")
signal Transitioned

@export var enemy: CharacterBody2D

func Enter() -> void:
	pass
	
func Exit() -> void:
	pass
	
func Update(_delta) -> void:
	if enemy.got_hit == true:
		Transitioned.emit(self, "flee")
