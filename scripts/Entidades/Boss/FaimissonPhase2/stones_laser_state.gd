extends State

@export var boss_head: Node2D

func Enter() -> void:
	await get_tree().create_timer(2).timeout
	boss_head.stones_attack()
	
	await boss_head.start_stones_laser()
	
	Transitioned.emit(self, "BlayBlade")

func Update(_delta: float) -> void:
		for stone in boss_head.stones:
			stone.set_laser_rotation(boss_head.global_position)

func Exit() -> void:
	boss_head.stones_idle()
	for stone in boss_head.stones:
		stone.stop_laser()
