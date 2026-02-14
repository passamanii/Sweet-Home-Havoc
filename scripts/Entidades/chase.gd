extends State
class_name ChaseState

func Enter():
	character.anim_player.play("Chasing")

func Update(_delta: float):
	if (character.can_attack()):
		Transitioned.emit(self, "Attack")
		return
	
	if (!character.can_chase()):
		Transitioned.emit(self, "Idle")
		return
	
	character.move()

func Exit():
	pass
