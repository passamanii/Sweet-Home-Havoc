extends State

@export var boss_head: Node2D
@export var boss_body: Faimisson2

func Enter() -> void:
	await get_tree().create_timer(0.2).timeout
	boss_head.stones_attack()
	boss_head.rotation_speed = 15
	await get_tree().create_timer(1.5).timeout
	
	Transitioned.emit(self, "PurpleStone")

func Update(delta: float) -> void:
	boss_head.move(delta)
	boss_body.move()

func Exit() -> void:
	boss_body.velocity = Vector2.ZERO
	boss_head.stones_idle()
	boss_body.global_position = Vector2.ZERO
	boss_head.global_position = Vector2.ZERO
	boss_head.rotation_speed = 1
