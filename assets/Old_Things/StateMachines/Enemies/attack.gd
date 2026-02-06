extends State
class_name AttackState

func Enter() -> void:
	if not enemy.anim_texture.animation_finished.is_connected(_on_anim_texture_finished):
		enemy.anim_texture.animation_finished.connect(_on_anim_texture_finished)
	
func Update(_delta) -> void:
	if enemy.run_from_player():
		Transitioned.emit(self, "flee")
		return
		
	if enemy.should_chase():
		Transitioned.emit(self, "chase")
		return

	if enemy.can_attack():
		enemy.anim_texture.play("attack")
		enemy.attack()
		enemy.start_cooldown()
		return

func Exit() -> void:
	if enemy.anim_texture.animation_finished.is_connected(_on_anim_texture_finished):
		enemy.anim_texture.animation_finished.disconnect(_on_anim_texture_finished)

func _on_anim_texture_finished() -> void:
	Transitioned.emit(self, "idle")
