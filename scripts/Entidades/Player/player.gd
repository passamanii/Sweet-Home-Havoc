extends CharacterBody2D
class_name BasePlayer

const SPEED = 450.0
const DASH_SPEED = SPEED * 5
const ATTACK_DISTANCE := 25.0

var can_dash: bool = true
var is_dashing: bool = false
var is_attacking: bool = false
var dir: Vector2
var knockback_force: int = 1000
var knockback_decay: int = 3000
var knockback_velocity: Vector2 = Vector2.ZERO
var facing: Vector2 = Vector2.ZERO
	
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var hitbox_area: Area2D = $HitboxArea
@onready var hitbox_collision: CollisionShape2D = $HitboxArea/HitboxCollision

func _ready() -> void:
	
	if (Player_Tracking.spawn_pos != Vector2.ZERO):
		
		global_position = Player_Tracking.spawn_pos
		
	if (Player_Tracking.spawn_facing != Vector2.ZERO):
		
		facing = Player_Tracking.spawn_facing
		
func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("reset"):
		
		get_tree().reload_current_scene()
	
	apply_knockback(delta)
		
	if (!is_attacking):
		movementPlayer()
		
	if (!is_dashing):
		attack()
		
	animationsPlayer()

func attack() -> void:
	if (Input.is_action_just_pressed("attack")):
		is_attacking = true
		update_attack_direction()

func enable_hitbox_collision() -> void:
	hitbox_collision.disabled = false

func update_attack_direction() -> void:
	var aim_dir := dir
	
	# Se estiver parado, usa a última direção que estava olhando
	if (aim_dir == Vector2.ZERO):
		match facing:
			"right": aim_dir = Vector2.RIGHT
			"left": aim_dir = Vector2.LEFT
			"back": aim_dir = Vector2.UP
			"front": aim_dir = Vector2.DOWN
	
	if (aim_dir != Vector2.ZERO):
		hitbox_area.rotation = aim_dir.angle()
		hitbox_collision.position = Vector2(ATTACK_DISTANCE, 0)

func apply_knockback(delta: float) -> void:
	if (knockback_velocity.length() > 0):
		knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, knockback_decay * delta)

func movementPlayer() -> void:
	if (knockback_velocity.length() > 0):
		velocity = knockback_velocity
		move_and_slide()
		return
	
	dir = Input.get_vector("left", "right", "up", "down")
	velocity = dir * SPEED
	
	if (is_dashing):
		velocity = dir * DASH_SPEED
	
	if (Input.is_action_just_pressed("dash") and can_dash):
		dash()
		
	move_and_slide()
	
func animationsPlayer() -> void:
	if (knockback_velocity.length() > 0):
		animation_player.play("Hurt_Front")
		return
	
	if (!is_attacking):
		
		if dir == Vector2.ZERO:
			
			if (facing == Vector2.RIGHT):
				
				animation_player.play("Idle_Right")
				
			elif (facing == Vector2.LEFT):
				
				animation_player.play('Idle_Left')
				
			elif (facing == Vector2.UP):
				
				animation_player.play('Idle_Back')
			else:
				animation_player.play('Idle_Front')
			
		elif (dir.x > 0):
			animation_player.play('Walking_Right')
			facing = Vector2.RIGHT
			
		elif (dir.x < 0):
			animation_player.play("Walking_Left")
			facing = Vector2.LEFT
			
		elif (dir.y < 0):
			animation_player.play("Walking_Back")
			facing = Vector2.UP
			
		elif (dir.y > 0):
			animation_player.play("Walking_Front")
			facing = Vector2.DOWN
			
	if (is_dashing):
		animation_player.play("Dash")
	
	if is_attacking:
		
		if (dir.x > 0 or facing == Vector2.RIGHT):
			
			animation_player.play("Pen_Attack_Right")
			
		elif (dir.x < 0 or facing == Vector2.LEFT):
			
			animation_player.play("Pen_Attack_Left")
			
		elif (dir.y < 0 or facing == Vector2.UP):
			
			animation_player.play("Pen_Attack_Back")
			
		elif (dir.y > 0 or facing == Vector2.DOWN):
			
			animation_player.play("Pen_Attack_Front")

func dash() -> void:
	is_dashing = true
	await get_tree().create_timer(0.3).timeout 
	is_dashing = false
	can_dash = false
	await get_tree().create_timer(1.0).timeout
	can_dash = true
	
func get_hit(damage: int, hit_position: Vector2) -> void:
	print("Player: AI!")
	var direction = (global_position - hit_position).normalized()
	knockback_velocity = direction * knockback_force
	
	Player_Stats.health -= damage
	if (Player_Stats.health <= 0):
		die()

func die() -> void:
	print("Morreu: ", self.name)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if (anim_name.contains('Attack')):
		is_attacking = false
		hitbox_collision.disabled = true
