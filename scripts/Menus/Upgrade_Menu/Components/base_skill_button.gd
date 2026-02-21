class_name SkillButton extends TextureButton

@onready var panel: Panel = $Panel
@onready var label: Label = $MarginContainer/Label
@onready var line_2d: Line2D = $Line2D
@export var skill_data: BasePerk

signal hovered(button)
signal unhovered

#var level : int = 0:
	#set(value):
		#level = value
		#label.text = str(level) + '/3'
		#
func _ready() -> void:
	update_lines()
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	
func _on_mouse_entered():
	emit_signal('hovered', self)

func _on_mouse_exited():
	emit_signal('unhovered')
	
func update_lines() -> void:
	
	if (get_parent() is SkillButton):
		line_2d.add_point(global_position + size/2)
		line_2d.add_point(get_parent().global_position + size/2)
		

func _on_pressed() -> void:
	
	if skill_data.level >= skill_data.perk_cost.size():
		return
	var current_cost: int = skill_data.perk_cost[skill_data.level]
	if Player_Stats.spentable_xp >= current_cost:
		Player_Stats.spentable_xp -= current_cost
		skill_data.level += 1
		panel.show_behind_parent = true
		line_2d.default_color = Color(0.671, 0.536, 0.251, 1.0)
		unlock_children()
	#if level == 0:	
		#if (Player_Stats.spentable_xp >= skill_data.perk_cost1):
			#level = min(level+1, 3)
			#panel.show_behind_parent = true
			#line_2d.default_color = Color(0.671, 0.536, 0.251, 1.0)
			#print(Player_Stats.spentable_xp)
			#Player_Stats.spentable_xp -= skill_data.perk_cost1
			#print(Player_Stats.spentable_xp)
			#
	#
	#if level == 1:	
		#if (Player_Stats.spentable_xp >= skill_data.perk_cost2):
			#level = min(level+1, 3)
			#panel.show_behind_parent = true
			#line_2d.default_color = Color(0.671, 0.536, 0.251, 1.0)
			#print(Player_Stats.spentable_xp)
			#Player_Stats.spentable_xp -= skill_data.perk_cost2
			#print(Player_Stats.spentable_xp)
			#
	#
	#if level == 2:	
		#if (Player_Stats.spentable_xp >= skill_data.perk_cost3):
			#level = min(level+1, 3)
			#panel.show_behind_parent = true
			#line_2d.default_color = Color(0.671, 0.536, 0.251, 1.0)
			#print(Player_Stats.spentable_xp)
			#Player_Stats.spentable_xp -= skill_data.perk_cost3
			#print(Player_Stats.spentable_xp)
			
func unlock_children():
	var skills = get_children()
	for skill in skills: 
		if skill is SkillButton and skill_data.level == 1:
			skill.show()
		
