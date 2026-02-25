extends Control

@onready var menu_brackground: TextureRect = $Menu_Brackground
@onready var label: Label = $"Menu_Brackground/Panel(Xp)/Label"
@onready var name_label: Label = $Skills_Details/Nome
@onready var desc_label: Label = $"Skills_Details/Descrição"
@onready var cost_label: Label = $Skills_Details/Custo
@onready var skills_details: TextureRect = $Skills_Details
@export var skill_buttons: Array[SkillButton]

var player: BasePlayer
var base_txt: String = 'XP: '
var base_lvl_txt: String = '/3'

func _ready() -> void:
	process_unlocked_skills_on_reload()
	connect_signals()
	player = get_tree().get_first_node_in_group('Player')

func _process(_delta: float) -> void:
	update_xp_shown()
	check_visibility()
	
func check_unlocked_skills(button: SkillButton):
	var skill_data = button.skill_data
	if skill_data.level == 0:
		pass
	else:
		button.level_label.text = str(skill_data.level) + base_lvl_txt
		button.panel.show_behind_parent = true
		button.line_2d.default_color = Color(0.671, 0.536, 0.251, 1.0)
		button.unlock_children()

func process_unlocked_skills_on_reload():
	for button in skill_buttons:
		check_unlocked_skills(button)

func check_visibility():
	if self.is_visible_in_tree():
		player.animation_player.play('Idle_Back')
		player.pause()
	elif !self.is_visible_in_tree():
		player.play()

func connect_signals():
	for button in skill_buttons:
		button.hovered.connect(_on_skill_hovered)
		button.unhovered.connect(_on_skill_unhovered)
		button.clicked.connect(_on_skill_clicked)
		
func _on_skill_clicked(button: SkillButton):
	update_detail_labels_shown(button)
	update_button_level_label(button)
	
func _on_skill_hovered(button: SkillButton):
	update_detail_labels_shown(button)
	skills_details.show()
	
func _on_skill_unhovered():
	skills_details.hide()
	
func update_xp_shown():
	label.text = base_txt + str(Player_Stats.spentable_xp)

func update_detail_labels_shown(button: SkillButton):
	var skill_data = button.skill_data
	if skill_data == null:
		return
	name_label.text = skill_data.perk_name
	desc_label.text = skill_data.perk_description
	if skill_data.level < 3:
		cost_label.text = 'Custo: %d' %skill_data.perk_cost[skill_data.level]
	elif skill_data.level == 3:
		cost_label.text = 'MAX'	
	
func update_button_level_label(button: SkillButton):
	var skill_data = button.skill_data
	var level_label = button.level_label
	level_label.text = str(skill_data.level) + base_lvl_txt
