extends Node2D

@export var player: BasePlayer
@export var enemy: PackedScene
@export var spawn_timer: Timer

const distance = 1500
var second: int = 0
var can_spanw: bool

func _physics_process(_delta: float) -> void:
	print(get_tree().get_node_count_in_group("Enemy"))
	if get_tree().get_node_count_in_group("Enemy") < 170:
		can_spanw = true
	else:
		can_spanw = false

func spawn(pos: Vector2) -> void:
	if can_spanw:
		var enemy_instance: BaseEnemy = enemy.instantiate()
		enemy_instance.position = pos
	
		get_tree().current_scene.add_child(enemy_instance)

func _on_spawn_timer_timeout() -> void:
	second += int(spawn_timer.wait_time)
	amount(second % 10)

func get_random_position() -> Vector2:
	return player.position + distance * Vector2.RIGHT.rotated(randf_range(0, 2 * PI))

func amount(number: int = 1):
	print(number)
	for i in range(number):
		spawn(get_random_position())
