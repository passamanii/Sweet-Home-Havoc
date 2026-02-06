extends State
class_name ChaseState

var direction: Vector2

func Enter() -> void:
	enemy.anim_texture.play("running")
	
func Update(delta) -> void:
	if enemy.should_attack():
		Transitioned.emit(self, "idle")
	else:
		enemy.move(delta)
