extends EnemyBase
class_name ThrowerEnemy

@export_category("Scenes")
@export var throwable_scene: PackedScene

func attack() -> void:
	var direction = get_player_direction()
	anim_texture.flip_h = direction.x > 0
	if attack_origin.position.x < 0:
		attack_origin.position *= -1 if direction.x > 0 else 1
	elif attack_origin.position.x > 0:
		attack_origin.position *= -1 if direction.x < 0 else 1
	
	var throwable = throwable_scene.instantiate()
	get_parent().add_child(throwable)
	
	throwable.global_position = attack_origin.global_position
	throwable.set_direction(player.global_position)

func get_hit(amount: int) -> void:
	super(amount)
	got_hit = true
	speed += 300
	await get_tree().create_timer(3).timeout
	got_hit = false
	speed -= 300
	
