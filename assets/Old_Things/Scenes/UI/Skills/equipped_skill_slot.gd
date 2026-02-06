extends Control

signal changed_skill

@export_range(1, 3) var skill_number: int

@export_category("Objects")
@export var texture_rect: TextureRect
@export var panel: Panel
@export var skill_number_label: Label
@export var empty_label: Label

var skill: ActivatableSkillStrategy = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	skill_number_label.text = 'Skill %d' % skill_number

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if skill == null:
		panel.show()
		empty_label.show()
		texture_rect.texture = null
		return
	
	panel.hide()
	empty_label.hide()

func _get_drag_data(_at_position: Vector2) -> Variant:
	if skill == null:
		return null
		
	var preview = TextureRect.new()
	preview.texture = skill.img
	preview.expand = true
	preview.size = size
	
	set_drag_preview(preview)
		
	return {
		"type": "unequipping_skill",
		"slot": self
	}

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data.type == "equipping_skill"

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	skill = data.skill
	texture_rect.texture = skill.img
	
	PlayerStats.equipped_skills['skill_%d' % skill_number] = skill
	emit_signal("changed_skill", skill_number)
