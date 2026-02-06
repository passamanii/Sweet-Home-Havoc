extends Control

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data.type == "unequipping_skill"
	
func _drop_data(_at_position: Vector2, data: Variant) -> void:
	data.slot.skill = null
	PlayerStats.equipped_skills['skill_%d' % data.slot.skill_number] = null
	data.slot.emit_signal("changed_skill", data.slot.skill_number)
