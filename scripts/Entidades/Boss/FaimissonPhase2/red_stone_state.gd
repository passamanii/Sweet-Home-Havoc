extends State

@export var boss_head: Node2D
@export var spawn_cooldown: Timer

var red_stone

func Enter() -> void:
	red_stone = boss_head.stones[1]
	await get_tree().create_timer(2).timeout
	spawn_cooldown.start()
	red_stone.shield_on = false
	red_stone.anim_sprite.play("Attacking")
	boss_head.start_following_attack()

func Update(_delta: float) -> void:
	if red_stone.broken:
		Transitioned.emit(self, "PurpleStone")

func Exit() -> void:
	spawn_cooldown.stop()

func _on_timer_timeout() -> void:
	boss_head.start_following_attack()
