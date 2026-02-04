extends CharacterBody2D


const SPEED = 300.0
const DASH_SPEED = 1500.0
var can_dash: bool = true
var is_dashing: bool = false

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	movementPlayer()
	move_and_slide()
	
	
func movementPlayer() -> void:
	
	var direction := Input.get_vector("left", "right", "up", "down")
	
	velocity = direction * SPEED
	
	if is_dashing:
		velocity = direction * DASH_SPEED
	
	if Input.is_action_just_pressed("dash") and can_dash:
		dash()
	
	animationsPlayer(direction)
	
	
func animationsPlayer(dir: Vector2) -> void:
	if dir.x > 0:
		animated_sprite.play("Walking_right")
	elif dir.x < 0:
		animated_sprite.play("Walking_left")
	elif dir.y < 0:
		animated_sprite.play("Walking_back")
	elif dir.y > 0:
		animated_sprite.play("Walking_front")


func dash() -> void:
		is_dashing = true
		await get_tree().create_timer(0.2).timeout 
		is_dashing = false
		can_dash = false
		await get_tree().create_timer(1.0).timeout
		can_dash = true
		 
