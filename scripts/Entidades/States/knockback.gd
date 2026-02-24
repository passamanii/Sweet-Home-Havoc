extends State
class_name KnockbackState

func Enter():
	character.anim_player.play("Hurt")
	character.attack_cooldown.stop()

func Update(delta: float):
	if (character.knockback_velocity.length() > 0):
		character.apply_knockback(delta)
		character.move()
		return
	
	Transitioned.emit(self, "Idle")

func Exit():
	pass
