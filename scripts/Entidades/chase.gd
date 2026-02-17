extends State
class_name ChaseState

func Enter():
	character.anim_player.play("Chasing")

func Update(_delta: float):
	if (character.knockback_velocity.length() > 0):
		Transitioned.emit(self, "Knockback")
		return
	
	if (character.can_attack()):
		Transitioned.emit(self, "Attack")
		return
	
	if (!character.can_chase()):
		Transitioned.emit(self, "Idle")
		return
	
	character.move()

func Exit():
	pass
