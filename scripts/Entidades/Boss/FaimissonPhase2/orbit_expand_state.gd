extends State

@export var boss_head: Node2D

func Enter() -> void:
	boss_head.stones_attack()
	await boss_head.start_expand_orbit()
	await get_tree().create_timer(5).timeout

func Update(delta: float):
	
	if boss_head.expanding and boss_head.orbit_radius <= 1500:
		boss_head.expand_orbit(delta)
	elif boss_head.shrinking and boss_head.orbit_radius >= 300:
		await boss_head.shrink_orbit(delta)
	else:
		boss_head.rotation_speed = 10
		boss_head.prepare_to_expand(delta)
	
	if !boss_head.expand_orbit_mode:
		Transitioned.emit(self, "StonesLaser")

func Exit() -> void:
	boss_head.stones_idle()
	boss_head.rotation_speed = 1
	boss_head.orbit_radius = 300
	boss_head.expanding = false
	boss_head.expand_orbit_mode = false
	boss_head.expanding_preparation = false
