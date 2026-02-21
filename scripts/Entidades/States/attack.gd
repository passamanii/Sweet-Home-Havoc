extends State
class_name AttackState

func Enter():
	character.anim_player.play("Attacking")
	character.start_cooldown()

func Update(_delta: float):
	if (character.knockback_velocity.length() > 0):
		Transitioned.emit(self, "Knockback")
		return
	
	if (character.anim_player.is_playing()):
		var dir: Vector2 = character.position.direction_to(character.target.position)
		
		if (dir.x > 0):
			character.sprite_2d.flip_h = true
		else:
			character.sprite_2d.flip_h = false
		return
	
	if (character.can_attack()):
		character.anim_player.play("Attacking")
		character.start_cooldown()
	elif (character.can_chase()):
		Transitioned.emit(self, "Chase")
	else:
		Transitioned.emit(self, "Idle")

func Exit():
	pass
