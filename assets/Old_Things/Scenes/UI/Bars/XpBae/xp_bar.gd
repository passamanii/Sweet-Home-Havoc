extends Control

@export_category("Objects")
@export var _progress_bar: ProgressBar
@export var label: Label

var level: int = 1

func _ready() -> void:
	PlayerStats.connect("xp_changed", set_value)

func set_value(curr_value: float, max_value: float):
	_progress_bar.max_value = max_value
	_progress_bar.value = curr_value
	
	label.text = '%d QI' % PlayerStats.level
