extends Control

@onready var menu_brackground: Panel = $Menu_Brackground
@onready var label: Label = $"Menu_Brackground/Panel(Xp)/Label"
@onready var name_label: Label = $Skills_Details/Nome
@onready var desc_label: Label = $"Skills_Details/Descrição"
@onready var cost_label: Label = $Skills_Details/Custo
@onready var skills_details: Panel = $Skills_Details
@onready var skill_button_1: SkillButton = $Menu_Brackground/Skill_Button_1
@onready var skill_button_2: SkillButton = $Menu_Brackground/Skill_Button_1/Skill_Button_2
@onready var skill_button_5: SkillButton = $Menu_Brackground/Skill_Button_1/Skill_Button_2/Skill_Button_5

var base_txt: String = 'XP: '
var base_lvl_txt: String = '/3'

func _ready() -> void:
	connect_signals()
			
func _process(_delta: float) -> void:
	update_xp_shown()

func check_unlocked_skills():
	pass
	#falta verificar quais skills o personagem já tem assim que ele
	#entra dnv na sala, pra árvore de habilidades ser condizente
	
func connect_signals():
	for button in menu_brackground.get_children():
		if button is SkillButton:
			button.hovered.connect(_on_skill_hovered)
			button.unhovered.connect(_on_skill_unhovered)
			button.clicked.connect(_on_skill_clicked)
	for button in skill_button_1.get_children():
		if button is SkillButton:
			button.hovered.connect(_on_skill_hovered)
			button.unhovered.connect(_on_skill_unhovered)
			button.clicked.connect(_on_skill_clicked)
	for button in skill_button_2.get_children():
		if button is SkillButton:
			button.hovered.connect(_on_skill_hovered)
			button.unhovered.connect(_on_skill_unhovered)
			button.clicked.connect(_on_skill_clicked)
	for button in skill_button_5.get_children():
		if button is SkillButton:
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
	if skill_data.level <= 2:
		cost_label.text = 'Custo: %d' %skill_data.perk_cost[skill_data.level]
	else:
		cost_label.text = 'MAX'	
	
func update_button_level_label(button: SkillButton):
	var skill_data = button.skill_data
	var level_label = button.level_label
	level_label.text = str(skill_data.level) + base_lvl_txt
