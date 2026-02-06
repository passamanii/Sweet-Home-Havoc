extends Control

@export_category("Objects")
@export var skill_name_label: Label
@export var skill_text_label: Label
@export var qi_amount_label: Label
@export var acquire_button: Button
@export var acquired_label: Label

signal bought(skill: String)

var skill_btn: SkillBtn

func _on_button_pressed() -> void:
	if !acquire_button.visible:
		return
	
	if skill_btn.skill_data.cost > PlayerStats.qi_points:
		return
	
	PlayerStats.qi_points -= skill_btn.skill_data.cost
	emit_signal("bought", skill_btn)
	acquire_button.visible = false
	acquired_label.visible = true

func put_infos(button: SkillBtn):
	skill_btn = button
	skill_name_label.text = button.skill_data.name
	skill_text_label.text = button.skill_data.text
	qi_amount_label.text = '%d QI' % button.skill_data.cost
	acquire_button.visible = !button.acquired
	acquired_label.visible = button.acquired
	
