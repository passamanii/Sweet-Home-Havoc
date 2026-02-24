class_name XPScript extends Label

signal finished

func _ready() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, 'scale', Vector2(2, 2), 0.2)
	tween.tween_property(self, 'scale', Vector2(2, 2), 2)
	await tween.finished
	tween.finished.connect(_finished)
	queue_free()

func _finished():
	emit_signal('finished')
