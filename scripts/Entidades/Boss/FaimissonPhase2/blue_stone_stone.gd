extends State

@export var boss_head: Node2D
@export var spawn_cooldown: Timer

var blue_stone

func Enter() -> void:
	blue_stone = boss_head.stones[0]
	await get_tree().create_timer(2).timeout
	spawn_cooldown.start()
	blue_stone.shield_on = false
	blue_stone.anim_sprite.play("Attacking")
	boss_head.spawn_enemies()

func Update(_delta: float) -> void:
	if blue_stone.broken:
		print("blue")
		Transitioned.emit(self, "RedStone")

func Exit() -> void:
	print("SAIU")
	spawn_cooldown.stop()

func _on_timer_timeout() -> void:
	boss_head.spawn_enemies()
