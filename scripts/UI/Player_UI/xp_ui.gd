class_name XpUi extends Control

@onready var progress_bar: TextureProgressBar = %Progress_Bar
@onready var level_label: Label = $Level_Label

@export var xp_levels: Array[ int ] = []

func _ready() -> void:
	connect_signals()
	
func connect_signals():
	Player_Stats.gained_xp.connect(_update_xp_shown)
	Player_Stats.gained_lvl.connect(_update_lvl_shown)

func _update_xp_shown(_xp):
	progress_bar.value = Player_Stats.xp

func _update_lvl_shown(_lvl):
	update_bar_on_level_up(_lvl)
	
func update_bar_on_level_up(_level):
	if Player_Stats.level != 10:
		progress_bar.min_value = xp_levels[_level-1]
		print(progress_bar.min_value)
		progress_bar.max_value = xp_levels[_level]	
		print(progress_bar.max_value)
		progress_bar.value = progress_bar.min_value
		level_label.text = str(_level)
	else:
		progress_bar.texture_progress = load("res://assets/Personagens/Principal/Barras/xp_ui_golden.tres")
		progress_bar.min_value = xp_levels[8]
		progress_bar.max_value = xp_levels[9]
		progress_bar.value = progress_bar.max_value
		level_label.text = str(_level)
