extends ProjectileBase

func _ready() -> void:
	var player = get_tree().get_first_node_in_group("Player")
	
	dir = player.facing if player.velocity == Vector2.ZERO else player.dir 
	
	life_time_timer.wait_time = life_time
	life_time_timer.start()
	rotation = dir.angle()

func _on_area_entered(area: Area2D) -> void:
	if area.get_parent() is BaseEnemy:
		var enemy: BaseEnemy = area.get_parent()
		enemy.get_hit()


func _on_dmg_per_sec_timeout() -> void:
	var bodies = get_overlapping_areas()
	for body in bodies:
		body.get_parent().get_hit()
