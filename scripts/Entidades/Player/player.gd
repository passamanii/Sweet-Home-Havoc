extends CharacterBody2D
class_name BasePlayer

const SPEED = 450.0
const DASH_SPEED = SPEED * 5
var can_dash: bool = true
var is_dashing: bool = false
var is_attacking: bool = false
var dir: Vector2
var facing: Vector2 = Vector2.ZERO
	
@onready var animation_player : AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	
	if (Globals.spawn_pos != Vector2.ZERO):
		
		global_position = Globals.spawn_pos
		
	if (Globals.spawn_facing != Vector2.ZERO):
		
		facing = Globals.spawn_facing
		
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
	
	#if (dir != Vector2.ZERO):
		#facing = dir.normalized()
		
	if is_dashing:
		velocity = dir * DASH_SPEED
	
	if Input.is_action_just_pressed("dash") and can_dash:
		dash()
		
	move_and_slide()
	
func animationsPlayer() -> void:
	
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
			
		elif dir.x > 0:
			animation_player.play('Walking_Right')
			facing = Vector2.RIGHT
			
		elif dir.x < 0:
			animation_player.play("Walking_Left")
			facing = Vector2.LEFT
			
		elif dir.y < 0:
			animation_player.play("Walking_Back")
			facing = Vector2.UP
			
		elif dir.y > 0:
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

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	
	if (anim_name.contains('Attack')):
		
		is_attacking = false
