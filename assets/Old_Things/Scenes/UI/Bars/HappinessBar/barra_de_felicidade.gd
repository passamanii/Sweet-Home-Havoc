extends Control

const ICON_FELICIDADE_1 = preload("uid://cu6urqovcrva8")
const ICON_FELICIDADE_2 = preload("uid://bbvxm8n7hoesc")
const ICON_FELICIDADE_3 = preload("uid://cgd73gn6xqew7")

@export_category("Objects")
@export var _progress_bar: ProgressBar
@export var _texture_rect: TextureRect
@export var regen_delay_timer: Timer
@export var regen_timer: Timer

func _ready() -> void:
	_progress_bar.max_value = PlayerStats.max_happiness
	_progress_bar.value = PlayerStats.happiness
	
	verify_style(PlayerStats.happiness, PlayerStats.max_happiness)

func set_value(curr_value: float, max_value: float) -> void:
	regen_timer.stop()
	
	verify_style(curr_value, max_value)
		
	_progress_bar.max_value = max_value
	_progress_bar.value = curr_value
	
	if _progress_bar.value < _progress_bar.max_value:
		regen_delay_timer.wait_time = PlayerStats.happiness_regen_delay
		regen_delay_timer.start()

func verify_style(curr_value: float, max_value: float) -> void:
	if curr_value > (60./100. * max_value):
		_texture_rect.texture = ICON_FELICIDADE_1
		_progress_bar.get("theme_override_styles/fill").bg_color = Color(1.0, 0.737, 0.0, 1.0)
		_progress_bar.get("theme_override_styles/background").bg_color = Color(0.302, 0.22, 0.0, 1.0)
	elif curr_value > (20./100. * max_value):
		_texture_rect.texture = ICON_FELICIDADE_2
		_progress_bar.get("theme_override_styles/fill").bg_color = Color(0.345, 0.396, 0.82, 1.0)
		_progress_bar.get("theme_override_styles/background").bg_color = Color(0.122, 0.137, 0.278, 1.0)
	else:
		_texture_rect.texture = ICON_FELICIDADE_3
		_progress_bar.get("theme_override_styles/fill").bg_color = Color(0.431, 0.431, 0.431, 1.0)
		_progress_bar.get("theme_override_styles/background").bg_color = Color(0.078, 0.078, 0.078, 1.0)

func regen() -> void:
	PlayerStats.happiness += PlayerStats.happiness_regen_amount
	_progress_bar.value = PlayerStats.happiness
	
	verify_style(PlayerStats.happiness, PlayerStats.max_happiness)
	
	if _progress_bar.value >= _progress_bar.max_value:
		regen_timer.stop()

func _on_regen_delay_timer_timeout() -> void:
	regen_timer.start()

func _on_regen_timer_timeout() -> void:
	regen()
