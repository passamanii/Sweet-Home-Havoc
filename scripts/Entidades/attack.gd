extends State
class_name AttackState

var is_attacking := false

func Enter():
	is_attacking = true
	
	character.anim_player.play("Attacking")
	character.start_cooldown()

func Update(_delta: float):
	if (character.anim_player.is_playing()):
		return
	
	if (character.can_attack()):
		Enter()
	elif (character.can_chase()):
		Transitioned.emit(self, "Chase")
	else:
		Transitioned.emit(self, "Idle")

func Exit():
	is_attacking = false
