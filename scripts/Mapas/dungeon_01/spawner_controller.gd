extends Node

@export_category("Objects")
@export var player: BasePlayer
@export var enemyList: Array[PackedScene]
@export var spawn_timer: Timer
@export var waves_controller: Node

const distance = 1500
var second: int = 0
var can_spanw: bool
var spawn_sequence: int = 0

func _physics_process(_delta: float) -> void:
	if get_tree().get_node_count_in_group("Enemy") < 170:
		can_spanw = true
	else:
		can_spanw = false

func spawn(pos: Vector2, glitched: bool = false) -> void:
	if waves_controller.actual_wave == spawn_sequence:
		spawn_sequence = 0
	if can_spanw:
		var enemy_instance: BaseEnemy = enemyList[spawn_sequence].instantiate()
		enemy_instance.position = pos
		if glitched:
			enemy_instance.damage *= 3
			enemy_instance.max_health *= 4
			enemy_instance.scale *= 1.8
			enemy_instance.xp_amount *= 2
			enemy_instance.sprite_2d.material = load("res://Shaders/glitch.tres")
		get_tree().current_scene.add_child(enemy_instance)
		spawn_sequence += 1

func _on_spawn_timer_timeout() -> void:
	second += int(spawn_timer.wait_time)
	amount(second % 10)

func get_random_position() -> Vector2:
	return player.position + distance * Vector2.RIGHT.rotated(randf_range(0, 2 * PI))

func amount(number: int = 1):
	if (!number): number = 1

	for i in range(number):
		if waves_controller.actual_wave >= 2 and second % (8 - waves_controller.actual_wave) == 0 and i <= (waves_controller.actual_wave - 1):
			spawn(get_random_position(), true)
		
		spawn(get_random_position())

func pause() -> void:
	can_spanw = false
	spawn_timer.stop()

func start() -> void:
	can_spanw = true
	spawn_timer.start()
	second = 0
