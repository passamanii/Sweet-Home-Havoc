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

func init_white() -> void:
	show()
	timer.start()
	anim_transition.play('fade_in_white')

func out() -> void:
	show()
	timer.start()
	anim_transition.play("fade_out")

func out_white() -> void:
	show()
	timer.start()
	anim_transition.play('fade_out_white')

func _on_timer_timeout() -> void:
	hide()
	emit_signal("transition_end")
