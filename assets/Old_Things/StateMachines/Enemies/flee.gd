extends State
class_name FleeState

func Enter() -> void:
	enemy.anim_texture.play("running")
	
func Update(delta) -> void:
	if enemy.got_hit:
		enemy.move(delta)
		return
	
	if enemy.should_attack():
		Transitioned.emit(self, "attack")
	elif enemy.should_chase():
		Transitioned.emit(self, "chase")
	
	enemy.move(delta)

func Exit() -> void:
	pass
