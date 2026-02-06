extends Control

@export_category("Objects")
@export var skill_canvas: Control
@export var skill_info: Control
@export var qi_points_label: Label

@onready var canvas_layer: CanvasLayer = $CanvasLayer

var dragging: bool = false
var zoom: float = 1
const ZOOM_STEP: float = 0.075
const MAX_ZOOM: float = 2
const MIN_ZOOM: float = 0.5
const MAX_MOVE: Vector2 = Vector2(560, 300)
const MIN_MOVE: Vector2 = Vector2(-560, -300)

func _ready() -> void:
	canvas_layer.hide()
	update_skill_btns()
	skill_info.connect("bought", add_skill)
	
func _process(_delta: float) -> void:
	qi_points_label.text = 'Pontos de QI: %d' % PlayerStats.qi_points
	update_skill_btns()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom = clamp(zoom - ZOOM_STEP, MIN_ZOOM, MAX_ZOOM)
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom = clamp(zoom + ZOOM_STEP, MIN_ZOOM, MAX_ZOOM)
		
		skill_canvas.scale = Vector2.ONE * zoom
		
		if event.button_index == MOUSE_BUTTON_LEFT:
			dragging = event.pressed

	elif event is InputEventMouseMotion and dragging:
		if skill_canvas.position > MAX_MOVE:
			skill_canvas.position = MAX_MOVE
			return
		elif skill_canvas.position < MIN_MOVE:
			skill_canvas.position = MIN_MOVE
			return
			
		skill_canvas.position += event.relative
		
	$CanvasLayer/SkillCanvas/SkillConnections.queue_redraw()

func _on_skill_btn_pressed(button: SkillBtn):
	skill_info.show()
	skill_info.put_infos(button)
	
func add_skill(skill_btn: SkillBtn):
	var skill := skill_btn.skill_data
	
	if PlayerStats.all_unlocked_skills_id.has(skill.id):
		return
	
	skill_btn.acquired = true
	skill.apply_skill()
	
	if skill is ActivatableSkillStrategy:
		PlayerStats.all_activatable_skills.append(skill)
	elif skill is BaseSkillStrategy:
		PlayerStats.all_passive_skills.append(skill)
		
		
	PlayerStats.all_unlocked_skills_id.append(skill.id)
	update_skill_btns()

func update_skill_btns() -> void:
	for btn in skill_canvas.get_children():
		if btn is SkillBtn:
			if can_unlock_skill(btn):
				btn.show()
				if not btn.is_connected("pressed", _on_skill_btn_pressed):
					btn.connect("pressed", _on_skill_btn_pressed)
			else:
				btn.hide()

func can_unlock_skill(btn: SkillBtn) -> bool:
	for req in btn.skill_data.requirements:
		if not PlayerStats.all_unlocked_skills_id.has(req):
			return false

	return true

func toggle() -> bool:
	canvas_layer.visible = !canvas_layer.visible
	set_process_input(canvas_layer.visible)
	return canvas_layer.visible
