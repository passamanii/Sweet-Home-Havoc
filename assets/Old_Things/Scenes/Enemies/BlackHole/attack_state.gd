extends AttackState

func Update(_delta) -> void:
	if enemy.run_from_player():
		Transitioned.emit(self, "flee")
		
	if enemy.should_chase():
		Transitioned.emit(self, "chase")

	if enemy.can_attack():
		enemy.anim_texture.play("attack")
		enemy.attack()
		enemy.start_cooldown()
	
	if enemy.shots_left == 0:
		Transitioned.emit(self, "reload")
