extends State
class_name IdleState

func Enter() -> void:
	enemy.anim_texture.play("idle")
	
func Update(_delta) -> void:
	if enemy.can_attack():
		Transitioned.emit(self, "attack")
	elif !enemy.should_attack():
		Transitioned.emit(self, "chase")

func Exit() -> void:
	pass
