extends Control

@export_range(1, 3) var skill_number: int
@export_category("Objects")
@export var texture_rect: TextureRect
@export var no_skill_label: Label
@export var key_label: Label
@export var cooldown_overlay: Control
@export var cooldown_label: Label
@export var cooldown_timer: Timer

var skill: ActivatableSkillStrategy
var player: CharacterBody2D
var can_use: bool = true

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	player.connect("used_skill", active_cooldown)

func _process(_delta: float) -> void:
	if skill == null:
		no_skill_label.show()
		return
		
	no_skill_label.hide()
	
	if !cooldown_timer.is_stopped():
		cooldown_label.text = str(round(cooldown_timer.time_left * 10) / 10)
	
	if can_use:
		cooldown_overlay.hide()
	else:
		cooldown_overlay.show()

func set_skill(_skill: ActivatableSkillStrategy) -> void:
	skill = _skill
	
	if skill == null:
		no_skill_label.show()
		texture_rect.texture = null
		cooldown_overlay.hide()
		return
	
	texture_rect.texture = skill.img
	cooldown_label.text = str(skill.cooldown)
	cooldown_timer.wait_time = skill.cooldown

func active_cooldown(skill_slot) -> void:
	if skill_slot == 'skill_%d' % skill_number:
		can_use = false
		cooldown_timer.start()

func _on_cooldown_timeout() -> void:
	can_use = true
