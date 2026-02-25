extends Area2D
class_name Interaction_With

@export var action: String = 'Interact'
@export var is_interactible: bool = true

var interact: Callable = func():
	pass

func _on_body_entered(_body: Node2D) -> void:
	if is_interactible:
		Interaction_Manager.register_area(self)

func _on_body_exited(_body: Node2D) -> void:
	Interaction_Manager.unregister_area(self)
