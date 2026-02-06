extends CharacterBody2D

const SPEED = 300.0
const DASH_SPEED = 1500.0
var can_dash: bool = true
var is_dashing: bool = false
var is_attacking: bool = false
var dir: Vector2

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	if !is_attacking:
		movementPlayer()
	if !is_dashing:
		attack()
	animationsPlayer()

func attack() -> void:
	if Input.is_action_just_pressed("attack"):
		is_attacking = true;

func movementPlayer() -> void:
	dir = Input.get_vector("left", "right", "up", "down")
	velocity = dir * SPEED
	
	if is_dashing:
		velocity = dir * DASH_SPEED
	
	if Input.is_action_just_pressed("dash") and can_dash:
		dash()
	

	move_and_slide()
	
func animationsPlayer() -> void:
	if (!is_attacking):
		if dir == Vector2.ZERO:
			animated_sprite.play("Idle")
		elif dir.x > 0:
			animated_sprite.play("Walking_right")
		elif dir.x < 0:
			animated_sprite.play("Walking_left")
		elif dir.y < 0:
			animated_sprite.play("Walking_back")
		elif dir.y > 0:
			animated_sprite.play("Walking_front")

	if (is_dashing):
		animated_sprite.play("Dash")
	
	if is_attacking:
		if dir.x > 0:
			animated_sprite.play("Attack_1_right")
		elif dir.x < 0:
			animated_sprite.play("Attack_1_left")
		elif dir.y < 0:
			animated_sprite.play("Attack_1_back")
		elif dir.y > 0:
			animated_sprite.play("Attack_1_front")
		else:
			animated_sprite.play("Attack_1_front")
			

func dash() -> void:
		is_dashing = true
		await get_tree().create_timer(0.2).timeout 
		is_dashing = false
		can_dash = false
		await get_tree().create_timer(1.0).timeout
		can_dash = true



func _on_animated_sprite_2d_animation_finished(source: AnimatedSprite2D) -> void:
	print(source.animation)
	if source.animation.contains("Attack"):
		is_attacking = false
