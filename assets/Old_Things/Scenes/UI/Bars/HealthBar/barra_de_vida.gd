extends Control

@export_category("Objects")
@export var _progress_bar: ProgressBar

func _ready() -> void:
	_progress_bar.max_value = PlayerStats.max_health
	_progress_bar.value = PlayerStats.health

func set_value(_curr_value: float, _max_value: float):
	_progress_bar.max_value = PlayerStats.max_health
	_progress_bar.value = PlayerStats.health
