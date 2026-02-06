extends Control

@onready var go_1_fall: Label = $Go1Fall
@onready var go_2_fall: Label = $Go2Fall
@onready var study_fall: Label = $StudyFall

@onready var ground_impact: AudioStreamPlayer = $GroundImpact

func _ready() -> void:
	animate()

func _on_start_pressed() -> void:
	GameProgress.start(5, 30)
	TransitionManager.change_scene("res://Scenes/Levels/level_base.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func animate() -> void:
	var tween: Tween = create_tween()

	tween.tween_interval(1)
	tween.tween_property(go_1_fall, "position", Vector2(311, 173), 0.3)
	tween.tween_callback(Callable(ground_impact.play))
	tween.tween_interval(0.1)
	tween.tween_property(go_2_fall, "position", Vector2(431, 173), 0.3)
	tween.tween_callback(Callable(ground_impact.play))
	tween.tween_interval(0.4)
	tween.tween_property(study_fall, "position", Vector2(572, 173), 0.3)
	tween.tween_callback(Callable(ground_impact.play))
