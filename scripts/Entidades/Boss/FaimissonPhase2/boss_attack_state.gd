extends State

@export var boss_head: Node2D

func Enter() -> void:
	await get_tree().create_timer(2).timeout
	boss_head.stones_attack()
	boss_head.rotation_speed = 10

func Update(delta: float) -> void:
	boss_head.move(delta)

func Exit() -> void:
	boss_head.stones_idle()
	boss_head.rotation_speed = 1
