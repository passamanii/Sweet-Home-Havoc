extends State

@export var boss_head: Faimisson2Head

var purple_stone

func Enter() -> void:
	purple_stone = boss_head.stones[2]
	await get_tree().create_timer(2).timeout
	purple_stone.shield_on = false
	boss_head.safe_from_purple_barrier = false
	boss_head.is_out_from_purple_area = false
	boss_head.start_purple_barrier()
	purple_stone.anim_sprite.play("Attacking")

func Update(delta: float) -> void:
	if purple_stone.shield_on:
		return
	boss_head.purple_barrier_collision.shape.radius -= delta * boss_head.purple_barrier_shrink_speed
	
	var radius = boss_head.purple_barrier_collision.shape.radius
	
	var safe_area_dir: Vector2 = boss_head.purple_barrier_area.global_position.direction_to(boss_head.purple_barrier_safe_area.global_position)
	boss_head.purple_barrier_safe_collision.global_position = safe_area_dir  * radius
	boss_head.purple_barrier_safe_sprite.global_position = safe_area_dir  * radius
	boss_head.purple_barrier_safe_sprite.scale *= Vector2(1, 1)
	
	var scale_factor = radius / 270
	boss_head.purple_barrier_sprite.scale = Vector2.ONE * scale_factor
	
	if radius <= 300:
		boss_head.purple_barrier_area.monitoring = false
		boss_head.start_purple_barrier()
	
	if purple_stone.broken:
		Transitioned.emit(self, "FinishIt")

func Exit() -> void:
	boss_head.safe_from_purple_barrier = true
	boss_head.is_out_from_purple_area = false
	boss_head.purple_barrier_area.monitoring = false
	boss_head.purple_barrier_safe_area.monitoring = false
	boss_head.purple_barrier_sprite.hide()
	boss_head.purple_barrier_safe_sprite.hide()
	print("SAIU")
