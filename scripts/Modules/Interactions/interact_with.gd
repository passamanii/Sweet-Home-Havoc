extends Area2D
class_name Interaction_With

@export var action: String = 'Interact'

var interact: Callable = func():
	pass


func _on_body_entered(_body: Node2D) -> void:
	Interaction_Manager.register_area(self)

func _on_body_exited(_body: Node2D) -> void:
	Interaction_Manager.unregister_area(self)
