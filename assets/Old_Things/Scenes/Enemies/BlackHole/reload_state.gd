extends State
class_name ReloadState

func Enter() -> void:
	if not enemy.anim_texture.animation_finished.is_connected(_on_animation_texture_finished):
		enemy.anim_texture.animation_finished.connect(_on_animation_texture_finished)
	enemy.anim_texture.play("reloading")
	enemy.reload()
	
func Update(delta) -> void:
	if enemy.should_attack():
		var direction = enemy.get_player_direction()
		enemy.anim_texture.flip_h = direction.x > 0
		return
	enemy.move(delta)

func Exit() -> void:
	if enemy.anim_texture.animation_finished.is_connected(_on_animation_texture_finished):
		enemy.anim_texture.animation_finished.disconnect(_on_animation_texture_finished)

func _on_animation_texture_finished() -> void:
	Transitioned.emit(self, "attack")
