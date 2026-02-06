extends Node2D

const SWAMP_MONSTER = preload("uid://bo621myqxip7n")
const ME = preload("uid://blusv6itdvlp5")
const CENTAUR = preload("uid://btq7q7adonkjx")
const BLACK_HOLE = preload("uid://bgogabyof50wk")

@export_category("Objects")
@export var _player: CharacterBody2D
@export var _hud: CanvasLayer
@export var spawn_timer: Timer

func _ready():
	GameProgress.time_finished.connect(Callable(get_tree(), "change_scene_to_file").bind("res://scenes/game_over.tscn"))

	_player.happiness_changed.connect(_hud.set_happiness)
	_player.health_changed.connect(_hud.set_health)

	_player.camera.limit_left = -192
	_player.camera.limit_right = 38592
	_player.camera.limit_top = -192
	_player.camera.limit_bottom = 38784

func _on_spawn_timer_timeout() -> void:
	spawn_enemy()
	spawn_timer.wait_time = randf_range(0.7, 2)

func spawn_enemy() -> void:
	var enemies := get_available_enemies()
	if enemies.is_empty():
		return

	var enemy_scene = enemies.pick_random()
	var enemy = enemy_scene.instantiate()
	add_child(enemy)

	enemy.global_position = get_spawn_position_outside_camera()

func get_available_enemies() -> Array:
	var enemies := []

	enemies.append(SWAMP_MONSTER)

	if PlayerStats.level >= 25:
		enemies.append(CENTAUR)

	if PlayerStats.level >= 50:
		enemies.append(ME)
		
	if PlayerStats.level >= 100:
		enemies.append(BLACK_HOLE)

	return enemies

func get_spawn_position_outside_camera() -> Vector2:
	var cam: Camera2D = _player.camera
	var viewport_size := get_viewport_rect().size
	var cam_center = cam.global_position

	var half_w = viewport_size.x / 2
	var half_h = viewport_size.y / 2

	var margin = 300

	var side = randi_range(0, 3)
	var pos := Vector2.ZERO

	match side:
		0:
			pos.x = randf_range(-half_w, half_w)
			pos.y = -half_h - margin
		1:
			pos.x = randf_range(-half_w, half_w)
			pos.y = half_h + margin
		2:
			pos.x = -half_w - margin
			pos.y = randf_range(-half_h, half_h)
		3:
			pos.x = half_w + margin
			pos.y = randf_range(-half_h, half_h)

	return cam_center + pos
