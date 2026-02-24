extends ProjectileBase

@export var turn_velocity: int = 1

var initial_dir: Vector2
var player_dir: Vector2

func _ready() -> void:
	super()
	
	dir = initial_dir

func _physics_process(delta: float) -> void:
	player_dir = global_position.direction_to(target.global_position)
	
	var player_dir_angle = player_dir.angle()
	var dir_angle = dir.angle()
	
	var new_angle = rotate_toward(dir_angle, player_dir_angle, turn_velocity * delta)
	
	dir = Vector2.from_angle(new_angle)
	
	rotation = new_angle - deg_to_rad(-90)
	global_position += dir * speed * delta

func _on_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("Player"):
		target.get_hit(damage, (target.position - position).normalized())
		queue_free()
	
	if area.is_in_group("RedStone"):
		queue_free()
