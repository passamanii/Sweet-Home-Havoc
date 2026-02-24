extends Control
class_name FadeTransition

@export_category("Objects")
@export var timer: Timer
@export var anim_transition: AnimationPlayer

signal transition_end

func init() -> void:
	show()
	timer.start()
	anim_transition.play('fade_in')

func out() -> void:
	show()
	timer.start()
	anim_transition.play("fade_out")

func _on_timer_timeout() -> void:
	hide()
	emit_signal("transition_end")
