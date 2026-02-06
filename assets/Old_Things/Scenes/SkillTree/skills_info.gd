extends Control

const SKILL_ICON = preload("uid://cmetp4tkm6m5n")

@export_category("Objects")
@export var canvas_layer: CanvasLayer
@export var passive_skills_box: GridContainer
@export var activatable_skills_box: GridContainer

func _ready() -> void:
	canvas_layer.hide()	

func toggle() -> bool:
	canvas_layer.visible = !canvas_layer.visible
	
	if canvas_layer.visible:
		clear_children(passive_skills_box)
		clear_children(activatable_skills_box)
		load_passive_skills()
		load_activatable_skills()
		
	return canvas_layer.visible

func load_passive_skills() -> void:
	for passive_skill in PlayerStats.all_passive_skills:
		var skill_icon = SKILL_ICON.instantiate()
		skill_icon.setup(passive_skill)
		passive_skills_box.add_child(skill_icon)
		
func load_activatable_skills() -> void:
	for activatable_skill in PlayerStats.all_activatable_skills:
		var skill_icon = SKILL_ICON.instantiate()
		skill_icon.setup(activatable_skill)
		activatable_skills_box.add_child(skill_icon)

func clear_children(node: Node) -> void:
	for child in node.get_children():
		child.queue_free()
