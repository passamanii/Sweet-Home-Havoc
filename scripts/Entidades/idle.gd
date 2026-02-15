extends State
class_name IdleState

func Enter():
	character.anim_player.play("Idle")

func Update(_delta: float):
	if (character.can_attack()):
		Transitioned.emit(self, "Attack")
	elif (!character.is_in_attack_range() and character.can_chase()):
		Transitioned.emit(self, "Chase")

func Exit():
	pass
