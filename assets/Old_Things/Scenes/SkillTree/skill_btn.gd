extends Control
class_name SkillBtn

signal pressed(skill_btn: SkillBtn, skill_data: SkillData)

@export var skill_data: SkillData

@export_category("Objects")
@export var texture_btn: TextureButton
@export var dark_overlay: Panel

var acquired: bool = false
var press_pos: Vector2
const CLICK_THRESHOLD: float = 6.0

func _ready() -> void:
	texture_btn.texture_normal = skill_data.img
	mouse_filter = Control.MOUSE_FILTER_PASS
	
func _process(_delta: float) -> void:
	if acquired:
		dark_overlay.show()

func _gui_input(event):
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			press_pos = get_global_mouse_position()
		else:
			if press_pos.distance_to(get_global_mouse_position()) <= CLICK_THRESHOLD:
				emit_signal("pressed", self)
