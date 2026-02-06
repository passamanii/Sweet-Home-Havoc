extends Control
class_name SkillIcon

@export_category("Objects")
@export var texture_rect: TextureRect

var skill: BaseSkillStrategy

func setup(_skill: BaseSkillStrategy) -> void:
	skill = _skill
	texture_rect.texture = skill.img

func _get_drag_data(_position):
	if not (skill is ActivatableSkillStrategy):
		return null

	var preview := TextureRect.new()
	preview.texture = skill.img
	preview.expand = true
	preview.size = size

	set_drag_preview(preview)

	return {
		"type": "equipping_skill",
		"skill": skill
	}

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data.type == "unequipping_skill"
	
func _drop_data(_at_position: Vector2, data: Variant) -> void:
	data.slot.skill = null
	PlayerStats.equipped_skills['skill_%d' % data.slot.skill_number] = null
