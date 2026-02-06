extends CanvasLayer

@onready var health_bar := %HealthBar
@onready var happiness_bar := %HappinessBar
@onready var time_label: Label = $MarginContainer/TimeLabel

func _ready() -> void:
	GameProgress.connect("time_changed", on_time_changed)
	time_label.text = "\n%02d:%02d" % [GameProgress.hours, GameProgress.minutes]

func on_time_changed(hours: int, minutes: int) -> void:
	if hours == 0 and minutes == 30:
		time_label.add_theme_color_override("font_color", Color(1.0, 0.0, 0.0))
	time_label.text = "\n%02d:%02d" % [hours, minutes]

func set_health(value: float, max_value: float):
	health_bar.set_value(value, max_value)

func set_happiness(value: float, max_value: float):
	happiness_bar.set_value(value, max_value)
