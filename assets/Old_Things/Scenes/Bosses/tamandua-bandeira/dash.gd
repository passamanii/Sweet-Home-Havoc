extends State

const MAX_DASHES := 10

func Enter() -> void:
	enemy.animation_tree.set("parameters/conditions/idle", false)
	enemy.animation_tree.set("parameters/conditions/sit", false)
	enemy.animation_tree.set("parameters/conditions/t_pose", true)

	enemy.dash_counts = 0
	_start_dash()


func Update(_delta) -> void:
	if enemy.dash_counts > MAX_DASHES:
		Transitioned.emit(self, "ants")
		return

	if not enemy.is_dashing:
		_start_dash()


func Exit() -> void:
	enemy.stop_dash()
	
func _start_dash():
	enemy.dash_counts += 1
	enemy.start_dash(enemy.player.global_position)
