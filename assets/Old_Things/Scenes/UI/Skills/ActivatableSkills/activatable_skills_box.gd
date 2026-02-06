extends Control

@export_category("Skills")
@export var skill_1_slot: Control
@export var skill_2_slot: Control
@export var skill_3_slot: Control

func _ready() -> void:
	for slot in get_tree().get_nodes_in_group("SkillSlot"):
		slot.connect("changed_skill", update_skills)

func update_skills(slot: int) -> void:
	var skill = PlayerStats.equipped_skills['skill_%d' % slot]
	
	match slot:
		1:
			skill_1_slot.set_skill(skill)
		2:
			skill_2_slot.set_skill(skill)
		3:
			skill_3_slot.set_skill(skill)
