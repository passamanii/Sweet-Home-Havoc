extends CharacterBody2D
class_name Faimisson2

@export_category("Variables")
@export var max_health: int = 4000
@export var flight_force: float = 3000.0
@export var damage: int = 30

@export_category("Objects")
@export var sprite: Sprite2D
@export var hitbox_area: Area2D
@export var hurtbox_area: Area2D
@export var anim_player: AnimationPlayer
@export var fade_transition: FadeTransition

var health: float
var player: BasePlayer
var dir: Vector2
var punch_mode: bool = false
var punch_target: Vector2

signal killed_faimisson

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	anim_player.play("Idle")
	health = max_health

func _on_hitbox_area_area_entered(_area: Area2D) -> void:
	player.get_hit(damage, (player.global_position - global_position).normalized())

func move() -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * get_parent().blay_blade_speed
	move_and_slide()

func start_punch() -> void:
	anim_player.play("Flying_Still")
	await get_tree().create_timer(1).timeout
	anim_player.play("Fly_Punch")
	punch_mode = true
	
	punch_target = player.global_position
	dir = global_position.direction_to(punch_target)
	velocity = dir * flight_force
	
	if dir.x > 0:
		sprite.flip_h = false
	elif dir.x < 0:
		sprite.flip_h = true

func do_air_punchs() -> bool:
	anim_player.play("Prepare_To_Flight_Punch")
	await anim_player.animation_finished
	start_punch()
	await get_tree().create_timer(5).timeout
	punch_mode = false
	velocity = Vector2.ZERO
	position = Vector2.ZERO
	anim_player.play("Flying_Still")
	await get_tree().create_timer(2).timeout
	return true

func get_hit() -> void:
	if hurtbox_area.monitoring:
		health -= Player_Stats.damage
		if health <= 0:
			print("Matou")
			killed_faimisson.emit()

func _on_hurtbox_area_area_entered(_area: Area2D) -> void:
	get_hit()
