extends Label

func _ready() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(2, 2), 0.2)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.1)
	await tween.finished
	queue_free()
