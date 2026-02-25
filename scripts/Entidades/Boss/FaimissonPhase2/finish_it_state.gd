extends State

@export var boss_head: Faimisson2Head
@export var boss_body: Faimisson2

func Enter() -> void:
	boss_head.shield_sprite.hide()
	boss_head.purple_barrier_area.monitoring = false
	boss_head.purple_barrier_safe_area.monitoring = false
	boss_head.shield.monitoring = false
	boss_body.hitbox_area.monitoring = false
	boss_body.hurtbox_area.monitoring = true

func Update(delta: float) -> void:
	if boss_head.rotation_speed <= 0:
		boss_head.rotation_speed = 0
		return
	boss_head.rotation_speed -= 0.3 * delta

func Exit() -> void:
	print("SAIU")
	#spawn_cooldown.stop()
