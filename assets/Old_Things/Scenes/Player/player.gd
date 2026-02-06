extends CharacterBody2D
class_name Player

@onready var skill_tree: Control = $"../SkillTree"
@onready var skills_info: Control = $"../SkillsInfo"
@onready var hud: CanvasLayer = $"../HUD"

@export_category("Objects")
@export var _anim_texture: AnimatedSprite2D
@export var _attack_zone: Area2D
@export var camera: Camera2D

signal happiness_changed(curr_happiness: float, max_happiness: float)
signal health_changed(curr_health: float, max_health: float)
signal used_skill(skill_slot: String)

enum player_state {IDLE, ATTACKING, MOVING, SKILLS}
var curr_state = player_state.IDLE
@export var base_speed = 800
@export var base_damage = 25
var _direction: Vector2
var idle_direction: String
var speed = base_speed
var attack_area_direction: Vector2
var attack_area_angle: float

func _ready():
	curr_state = player_state.IDLE
	_anim_texture.play("front_idle")

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().call_deferred("change_scene_to_file", "res://Scenes/Levels/level_base.tscn")
	if Input.is_action_just_pressed("toggle_skills_info"):
		var is_skills_info_visible: bool = skills_info.toggle()
		if is_skills_info_visible:
			curr_state = player_state.SKILLS
			skill_tree.canvas_layer.hide()
			hud.hide()
		else:
			curr_state = player_state.IDLE
			hud.show()
	if Input.is_action_just_pressed("toggle_skill_tree"):
		var is_skill_tree_visible = skill_tree.toggle()
		if is_skill_tree_visible:
			curr_state = player_state.SKILLS
			skills_info.canvas_layer.hide()
			hud.hide()
		else:
			curr_state = player_state.IDLE
			hud.show()
			
		animate()
		
	if curr_state == player_state.ATTACKING:
		return
	move()
	if curr_state == player_state.SKILLS:
		return
	skills()
	if Input.is_action_just_pressed("attack"):
		curr_state = player_state.ATTACKING
		attack()
	animate()

func move():
	speed = base_speed * PlayerStats.speed_multiplier
	
	if Input.is_key_label_pressed(KEY_SHIFT) and PlayerStats.happiness > 0:
		if speed < speed * 2:
			speed *= 2
		if PlayerStats.happiness > 0:
			PlayerStats.happiness -= 0.5
			emit_signal("happiness_changed", PlayerStats.happiness, PlayerStats.max_happiness)
	
	if _direction != Vector2.ZERO:
		attack_area_angle = _direction.angle()
		attack_area_direction = _direction * 4
		_attack_zone.position = attack_area_direction
		_attack_zone.rotation = attack_area_angle
		
	_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = _direction * speed
	
	
	move_and_slide()

func get_direction() -> String:
	if abs(_direction.x) < abs(_direction.y):
		return "DOWN" if _direction.y > 0 else "UP"
	else:
		return "LEFT" if _direction.y > 0 else "RIGHT"

func animate() -> void:
	if curr_state == player_state.ATTACKING:
		match idle_direction:
			"UP":
				_anim_texture.play("back_attack")
			"DOWN":
				_anim_texture.play("front_attack")
			"LEFT":
				_anim_texture.play("side_attack")
			"RIGHT":
				_anim_texture.play("side_attack")
		return
	
	if _direction == Vector2.ZERO or curr_state == player_state.SKILLS:
		if _direction == Vector2.ZERO and curr_state != player_state.SKILLS:
			curr_state = player_state.IDLE
		
		match idle_direction:
			"UP":
				_anim_texture.play("back_idle")
			"DOWN":
				_anim_texture.play("front_idle")
			"LEFT":
				_anim_texture.play("side_idle")
			"RIGHT":
				_anim_texture.play("side_idle")
		return
				
	curr_state = player_state.MOVING
	idle_direction = get_direction()
	
	if abs(_direction.x) < abs(_direction.y):
		_anim_texture.play("front_walk" if _direction.y > 0 else "back_walk")
	else:
		_anim_texture.flip_h = false if _direction.x > 0 else true
		_anim_texture.play("side_walk")

func attack() -> void:
	_attack_zone.monitoring = true
	await get_tree().create_timer(0.1).timeout
	_attack_zone.monitoring = false

func skills() -> void:
	var all_equipped_skills = get_tree().get_nodes_in_group("EquippedSkill")
	if Input.is_action_just_pressed("skill_1"):
		if PlayerStats.equipped_skills["skill_1"] != null:
			if !all_equipped_skills[0].can_use:
				return
			PlayerStats.equipped_skills["skill_1"].activate()
			emit_signal("used_skill", "skill_1")
			await get_tree().create_timer(PlayerStats.equipped_skills["skill_1"].revert_timer).timeout
			PlayerStats.equipped_skills["skill_1"].revert()
	if Input.is_action_just_pressed("skill_2"):
		if PlayerStats.equipped_skills["skill_2"] != null:
			if !all_equipped_skills[1].can_use:
				return
			PlayerStats.equipped_skills["skill_2"].activate()
			emit_signal("used_skill", "skill_2")
			await get_tree().create_timer(PlayerStats.equipped_skills["skill_2"].revert_timer).timeout
			PlayerStats.equipped_skills["skill_2"].revert()
	if Input.is_action_just_pressed("skill_3"):
		if PlayerStats.equipped_skills["skill_3"] != null:
			if !all_equipped_skills[2].can_use:
				return
			PlayerStats.equipped_skills["skill_3"].activate()
			emit_signal("used_skill", "skill_3")
			await get_tree().create_timer(PlayerStats.equipped_skills["skill_3"].revert_timer).timeout
			PlayerStats.equipped_skills["skill_3"].revert()

func get_hit(amount: float) -> void:
	PlayerStats.health -= amount
	health_changed.emit(PlayerStats.health, PlayerStats.max_health)

func _on_anim_texture_animation_finished() -> void:
	if curr_state == player_state.ATTACKING:
		curr_state = player_state.IDLE

func _on_hitbox_area_exited(area: Area2D) -> void:
	var body = area.get_parent()
	if body.is_in_group("Enemy") or body.is_in_group("Boss"):
		body.get_hit(base_damage * PlayerStats.base_damage_multiplier)
