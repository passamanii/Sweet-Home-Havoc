extends AttackState

func Update(_delta) -> void:
	if enemy.run_from_player():
		Transitioned.emit(self, "flee")
		return
		
	if enemy.should_chase():
		if enemy.anim_texture.animation == "attack":
			return
			
		Transitioned.emit(self, "chase")
		return

	if enemy.can_attack():
		enemy.anim_texture.play("attack")
		enemy.start_cooldown()
		return
		
func _on_anim_texture_finished() -> void:
	enemy.attack()
	Transitioned.emit(self, "idle")
