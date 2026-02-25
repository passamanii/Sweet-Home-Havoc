class_name BasePlayer extends CharacterBody2D

@export var ink_ball_scene: PackedScene
@export var jbl_sound_scene: PackedScene

var SPEED: int = 450
var DASH_SPEED: int = SPEED * 5
const ATTACK_DISTANCE := 25.0

var can_dash: bool = true
var is_dashing: bool = false
var is_attacking: bool = false
var dir: Vector2
var knockback_force: int = 1000
var knockback_decay: int = 3000
var knockback_velocity: Vector2 = Vector2.ZERO
var facing: Vector2 = Vector2.ZERO
var mouse_dir: Vector2 = Vector2.ZERO
var can_move: bool = true

var xp: int = 0
var level: int = 1
var health: int = 30 #Cada coração equivale à 10hp
var max_health: float = 30
var damage: float = 10
var regen: int = 0
var armor: float = 0


@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox_area: Area2D = $HitboxArea
@onready var hitbox_collision: CollisionShape2D = $HitboxArea/HitboxCollision
@onready var camera_2d: Camera2D = $Camera2D
@onready var regeneration_timer: Timer = $Regeneration_Timer
@onready var marker_2d: Marker2D = $Marker2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var xp_ui: XpUi = $"/root/PlayerHud/Control/MarginContainer/Xp_UI"

@export var xp_popup: PackedScene
@export var lvl_popup: PackedScene

signal player_died

func _ready() -> void:
	connect_signals()
	define_spawn()
	define_stats()
	update_health_bar()

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("change_weapon"):
		is_attacking = false
		hitbox_collision.disabled = true
		animated_sprite.flip_h = false
		
		if Player_Stats.weapen_equipped == Player_Stats.weapon.PEN:
			Player_Stats.weapen_equipped = Player_Stats.weapon.INK
		elif Player_Stats.weapen_equipped == Player_Stats.weapon.INK:
			Player_Stats.weapen_equipped = Player_Stats.weapon.JBL
		else:
			Player_Stats.weapen_equipped = Player_Stats.weapon.PEN
		
		return
		
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	
	apply_knockback(delta)
	
	if (Player_Stats.weapen_equipped == Player_Stats.weapon.INK):
		var mouse_pos = get_global_mouse_position()
		mouse_dir = (mouse_pos - global_position).normalized()
		
	if (can_move and (!is_attacking or Player_Stats.weapen_equipped == Player_Stats.weapon.INK or knockback_velocity.length() > 0)):
		movementPlayer()
		
	if (can_move and !is_attacking and !is_dashing and !knockback_velocity.length() > 0 or Player_Stats.weapen_equipped == Player_Stats.weapon.INK):
		attack()
		
	animationsPlayer()

func _process(_delta: float) -> void:
	define_stats()
	update_health_bar()

func connect_signals():
	Player_Stats.gained_xp.connect(_show_xp_gained)
	Player_Stats.gained_lvl.connect(_show_new_level)
	
func define_spawn():
	Player_Tracking.player = self
	if (Player_Tracking.spawn_pos != Vector2.ZERO):
		position = Player_Tracking.spawn_pos
		print(position)
	if (Player_Tracking.spawn_facing != Vector2.ZERO):
		facing = Player_Tracking.spawn_facing
		print(facing)
		
func save_stats():
	Player_Stats.temp_xp = Player_Stats.xp
	Player_Stats.temp_level = Player_Stats.level
	Player_Stats.temp_max_health = Player_Stats.max_health
	Player_Stats.temp_damage = Player_Stats.damage
	
func update_stats_on_death():
	Player_Stats.health = Player_Stats.temp_max_health
	Player_Stats.damage = Player_Stats.temp_damage
	Player_Stats.xp = Player_Stats.temp_xp
	Player_Stats.level = Player_Stats.temp_level
	xp_ui._update_lvl_shown(Player_Stats.level)
	xp_ui._update_xp_shown(Player_Stats.xp)
	
func define_stats():
	if (Player_Stats.xp != xp):
		xp = Player_Stats.xp
	if (Player_Stats.level != level):
		level = Player_Stats.level
	if (Player_Stats.health != health):
		health = Player_Stats.health
		max_health = Player_Stats.max_health
	if (Player_Stats.damage != damage):
		damage = Player_Stats.damage
	if (Player_Stats.speed != SPEED):
		SPEED = Player_Stats.speed	
	if (Player_Stats.armor != armor):
		armor = Player_Stats.armor
	if (Player_Stats.regen != regen):
		regen = Player_Stats.regen

func update_health_bar():
	PlayerHud.update_hp(health, max_health)

func regenerate():
	var health_to_regenerate = 5 + regen
	if Player_Stats.health != Player_Stats.max_health:
		if (health_to_regenerate + Player_Stats.health) > Player_Stats.max_health:
			Player_Stats.health = Player_Stats.max_health
		else:
			Player_Stats.health += health_to_regenerate

func attack() -> void:
	if (Input.is_action_just_pressed("attack")):
		is_attacking = true
		
		if (Player_Stats.weapen_equipped == Player_Stats.weapon.PEN):
			update_attack_direction()
			
		elif (Player_Stats.weapen_equipped == Player_Stats.weapon.INK):
			if get_tree().current_scene.name == "Biblioteca":
				#is_attacking = false
				return
			var ink_ball = ink_ball_scene.instantiate()
			ink_ball.global_position = marker_2d.global_position
			get_tree().current_scene.add_child(ink_ball)
			
		elif (Player_Stats.weapen_equipped == Player_Stats.weapon.JBL):
			var jbl_sound = jbl_sound_scene.instantiate()
			var jbl_dir = facing if velocity == Vector2.ZERO else dir 
			jbl_sound.global_position = global_position + jbl_dir * 100
			get_tree().current_scene.add_child(jbl_sound)

func enable_hitbox_collision() -> void:
	hitbox_collision.disabled = false

func update_attack_direction() -> void:
	var aim_dir := dir
	
	if (aim_dir == Vector2.ZERO):
		match facing:
			Vector2.RIGHT: aim_dir = Vector2.RIGHT
			Vector2.LEFT: aim_dir = Vector2.LEFT
			Vector2.UP: aim_dir = Vector2.UP
			Vector2.DOWN: aim_dir = Vector2.DOWN
		
	if (aim_dir != Vector2.ZERO):
		hitbox_area.rotation = aim_dir.angle()
		hitbox_collision.position = Vector2(ATTACK_DISTANCE, 0)

func apply_knockback(delta: float) -> void:
	if (knockback_velocity.length() > 0):
		is_attacking = false
		hitbox_collision.disabled = true
		knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, knockback_decay * delta)

func movementPlayer() -> void:
	if (knockback_velocity.length() > 0):
		velocity = knockback_velocity
		move_and_slide()
		return
	
	dir = Input.get_vector("left", "right", "up", "down")
	
	velocity = dir * SPEED
	
	if (velocity != Vector2.ZERO):
		ray_cast_2d.target_position = velocity.normalized() * 50
		
	
	if (is_dashing):
		velocity = dir * DASH_SPEED
	
	if (Input.is_action_just_pressed("dash") and can_dash):
		dash()
		
	move_and_slide()

func animationsPlayer() -> void:
	if (knockback_velocity.length() > 0):
		animation_player.play("Hurt_Front")
		return
	
	var using_ink = Player_Stats.weapen_equipped == Player_Stats.weapon.INK
	
	var current_dir = dir
	if (using_ink):
		current_dir = mouse_dir
		if abs(mouse_dir.x) > abs(mouse_dir.y):
			if mouse_dir.x > 0:
				marker_2d.position = Vector2(16, 6.5)
				facing = Vector2.RIGHT
			else:
				marker_2d.position = Vector2(-16, 6.5)
				facing = Vector2.LEFT
		else:
			if mouse_dir.y < 0:
				marker_2d.position = Vector2(11.5, -18)
				facing = Vector2.UP
			else:
				marker_2d.position = Vector2(-11, 28)
				facing = Vector2.DOWN

	if (!is_attacking):
		if velocity == Vector2.ZERO:
			if using_ink:
				if abs(mouse_dir.x) > abs(mouse_dir.y):
					if mouse_dir.x > 0:
						animation_player.play("Idle_Pen_Side")
						animated_sprite.flip_h = false
					else:
						animation_player.play("Idle_Pen_Side")
						animated_sprite.flip_h = true
				else:
					if mouse_dir.y < 0:
						animation_player.play("Idle_Pen_Back")
					else:
						animation_player.play("Idle_Pen_Front")
			else:
				if facing == Vector2.RIGHT:
					animation_player.play("Idle_Right")
				elif facing == Vector2.LEFT:
					animation_player.play("Idle_Left")
				elif facing == Vector2.UP:
					animation_player.play("Idle_Back")
				else:
					animation_player.play("Idle_Front")
			return

		if using_ink:
			if abs(mouse_dir.x) > abs(mouse_dir.y):
				if mouse_dir.x > 0:
					animation_player.play("Walking_Pen_Side")
					animated_sprite.flip_h = false
					facing = Vector2.RIGHT
				else:
					animation_player.play("Walking_Pen_Side")
					animated_sprite.flip_h = true
					facing = Vector2.LEFT
			else:
				if mouse_dir.y < 0:
					animation_player.play("Walking_Pen_Back")
					facing = Vector2.UP
				else:
					animation_player.play("Walking_Pen_Front")
					facing = Vector2.DOWN
			

		elif current_dir.x > 0:
			animation_player.play("Walking_Right")
			facing = Vector2.RIGHT
		elif current_dir.x < 0:
			animation_player.play("Walking_Left")
			facing = Vector2.LEFT
		elif current_dir.y < 0:
			animation_player.play("Walking_Back")
			facing = Vector2.UP
		elif current_dir.y > 0:
			animation_player.play("Walking_Front")
			facing = Vector2.DOWN
			
	if (is_dashing):
		animation_player.play("Dash")
	if is_attacking:
		if (Player_Stats.weapen_equipped == Player_Stats.weapon.PEN):
			if (dir.x > 0 or facing == Vector2.RIGHT):
				animation_player.play("Pen_Attack_Right")
			elif (dir.x < 0 or facing == Vector2.LEFT):
				animation_player.play("Pen_Attack_Left")
			elif (dir.y < 0 or facing == Vector2.UP):
				animation_player.play("Pen_Attack_Back")
			elif (dir.y > 0 or facing == Vector2.DOWN):
				animation_player.play("Pen_Attack_Front")

		elif using_ink:
			if get_tree().current_scene.name == "Biblioteca":
				is_attacking = false
				return
			if animation_player.current_animation.contains("Shoot"):
				return
				
			if abs(mouse_dir.x) > abs(mouse_dir.y):
				if mouse_dir.x > 0:
					animation_player.play("Shoot_Side")
					animated_sprite.flip_h = false
				else:
					animation_player.play("Shoot_Side")
					animated_sprite.flip_h = true
			else:
				if mouse_dir.y < 0:
					animation_player.play("Shoot_Back")
				else:
					animation_player.play("Shoot_Front")

		elif (Player_Stats.weapen_equipped == Player_Stats.weapon.JBL):
			if (dir.x > 0 or facing == Vector2.RIGHT):
				animation_player.play("Jbl_Attack_Right")
			elif (dir.x < 0 or facing == Vector2.LEFT):
				animation_player.play("Jbl_Attack_Left")
			elif (dir.y < 0 or facing == Vector2.UP):
				animation_player.play("Jbl_Attack_Back")
			elif (dir.y > 0 or facing == Vector2.DOWN):
				animation_player.play("Jbl_Attack_Front")
				
	

func dash() -> void:
	is_dashing = true
	await get_tree().create_timer(0.3).timeout 
	is_dashing = false
	can_dash = false
	await get_tree().create_timer(1.0).timeout
	can_dash = true
	
func get_hit(enemy_damage: int, knockback_dir: Vector2, knockback_power: int = knockback_force) -> void:
	knockback_velocity = knockback_dir * knockback_power
	var resultant_damage = enemy_damage - floor(armor / 10)
	
	regeneration_timer.start()
	Player_Stats.health -= resultant_damage
	if (Player_Stats.health <= 0):
		die()

func _show_xp_gained(_xp):
	var popup = xp_popup.instantiate()
	popup.text = '+ %s XP' % _xp
	popup.position = self.global_position + Vector2(-50, -50)
	get_tree().current_scene.add_child(popup)

func _show_new_level(_lvl):
	await get_tree().create_timer(2.5).timeout
	var popup = lvl_popup.instantiate()
	popup.text = 'LVL %s!' % _lvl
	popup.position = self.global_position + Vector2(-50, -50)
	get_tree().current_scene.add_child(popup)
	
func die() -> void:
	Game_Controller.player_alive = false
	var cam = camera_2d
	cam.reparent(get_tree().current_scene)
	cam.global_position = global_position
	player_died.emit()
	get_tree().reload_current_scene()
	update_stats_on_death()

func pause() -> void:
	set_physics_process(false)
	set_process(false)

func play() -> void:
	set_physics_process(true)
	set_process(true)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if (anim_name.contains('Attack')):
		is_attacking = false
		animated_sprite.flip_h = false
		hitbox_collision.disabled = true
	elif (anim_name.contains("Shoot")):
		is_attacking = false

func _input(event: InputEvent) -> void:
	if can_move:
		if event.is_action_pressed("interact"):
			var target = ray_cast_2d.get_collider()
			if target != null:
				if target.is_in_group("NPC"):
					can_move = false
					target.start_dialog()

func _on_regeneration_timer_timeout() -> void:
	regenerate()
