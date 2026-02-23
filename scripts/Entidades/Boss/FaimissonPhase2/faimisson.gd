extends CharacterBody2D
class_name Faimisson2

@export_category("Variables")
@export var max_health: int = 1
@export var flight_force: float = 2000.0
@export var damage: int = 1

@export_category("Objects")
@export var sprite: Sprite2D
@export var hitbox_area: Area2D
@export var anim_player: AnimationPlayer

var health: int
var player: BasePlayer
var dir: Vector2
var punch_mode: bool = false
var punch_target: Vector2

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	anim_player.play("Idle")
	health = max_health

func _on_hitbox_area_area_entered(_area: Area2D) -> void:
	player.get_hit(damage, (player.global_position - global_position).normalized())

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
	await get_tree().create_timer(10).timeout
	punch_mode = false
	velocity = Vector2.ZERO
	position = Vector2.ZERO
	anim_player.play("Idle")
	await get_tree().create_timer(2).timeout
	return true
