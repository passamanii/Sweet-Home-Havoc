extends CanvasLayer

@export_category("Objects")
@export var _animation: AnimationPlayer
@export var _timer: Timer

signal fade_finished

func fade_in() -> void:
	_animation.play("fade_in")
	_timer.start()

func fade_out() -> void:
	_animation.play("fade_out_periodo")

func _on_fade_timer_timeout() -> void:
	emit_signal("fade_finished")

func _on_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out_periodo":
		queue_free()
