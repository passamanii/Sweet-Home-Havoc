extends State

func Enter() -> void:
	enemy.animation_tree.set("parameters/conditions/idle", true)
	enemy.animation_tree.set("parameters/conditions/sit", false)
	enemy.animation_tree.set("parameters/conditions/t_pose", false)
	await get_tree().create_timer(2).timeout
	Transitioned.emit(self, "dash")
