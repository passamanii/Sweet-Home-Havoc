extends Area2D
class_name ProjectileBase

@export_category("Variables")
@export var damage: int
@export var speed: int
@export var life_time: float

@export_category("Objects")
@export var life_time_timer: Timer

var target: BasePlayer
var dir: Vector2

func _ready() -> void:
	target = get_tree().get_first_node_in_group("Player")
	
	dir = position.direction_to(target.position)
	
	life_time_timer.wait_time = life_time
	life_time_timer.start()
	rotation = dir.angle() + deg_to_rad(-90)

func _physics_process(delta: float) -> void:
	global_position += dir * speed * delta

func _on_life_time_timeout() -> void:
	queue_free()

func _on_area_entered(_area: Area2D) -> void:
	target.get_hit(damage, (target.position - position).normalized())
	queue_free()
