extends ProjectileBase

var end_pos: Vector2

func _ready() -> void:
	end_pos = get_global_mouse_position()
	dir = global_position.direction_to(end_pos)

func _physics_process(delta: float) -> void:
	global_position += dir * speed * delta
	if global_position.distance_to(end_pos) <= 10:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.get_parent().has_method("get_hit"):
		var enemy = area.get_parent()
		
		enemy.get_hit()
		queue_free()
