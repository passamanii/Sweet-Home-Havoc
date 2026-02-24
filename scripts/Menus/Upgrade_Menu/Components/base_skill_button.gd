class_name SkillButton extends TextureButton

@onready var panel: Panel = $Panel
@onready var level_label: Label = $MarginContainer/Level_Label
@onready var line_2d: Line2D = $Line2D
@export var skill_data: BasePerk

signal hovered(button)
signal clicked(button)
signal unhovered

func _ready() -> void:
	icon()
	update_lines()
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	
func _on_mouse_entered():
	emit_signal('hovered', self)

func _on_mouse_exited():
	emit_signal('unhovered')
	
func update_lines() -> void:
	if get_parent() is SkillButton:
		line_2d.add_point(global_position + size/2)
		line_2d.add_point(get_parent().global_position + size/2)

func _on_pressed() -> void:
	if skill_data.level >= skill_data.perk_cost.size():
		return
	var current_cost: int = skill_data.perk_cost[skill_data.level]
	if Player_Stats.spentable_xp >= current_cost:
		Player_Stats.spentable_xp -= current_cost
		skill_data.apply_perk()
		unlock()
	emit_signal('clicked', self)
			
func unlock_children():
	var skills = get_children()
	for skill in skills: 
		if skill is SkillButton and skill_data.level > 0:
			skill.show()
		
func icon():
	self.texture_normal = skill_data.icon

func unlock():
	panel.show_behind_parent = true
	line_2d.default_color = Color(0.671, 0.536, 0.251, 1.0)
	unlock_children()

func check_unlocked():
	if skill_data.level >= 3:
		unlock()
