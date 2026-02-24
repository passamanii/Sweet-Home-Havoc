extends State
class_name IdleState

func Enter():
	character.anim_player.play("Idle")

func Update(_delta: float):
	if (character.knockback_velocity.length() > 0):
		Transitioned.emit(self, "Knockback")
		return
	
	if (character.can_attack()):
		Transitioned.emit(self, "Attack")
	elif (!character.is_in_range and character.can_chase()):
		Transitioned.emit(self, "Chase")

func Exit():
	pass
