extends CharacterBody2D
class_name EnemyBase

@export_category("Objects")
@export var anim_texture: AnimatedSprite2D
@export var collision: CollisionShape2D
@export var hurt_box: Area2D
@export var attack_origin: Marker2D
@export var attack_cooldown: Timer

@export_category("Variables")
@export var _max_health: int
@export var speed: int
@export var _damage: int
@export var attack_range: int
@export var flee_range: int
@export var xp: int

var health: int
var player: Player
var got_hit: bool = false

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	health = _max_health

func move(_delta: float) -> void:
	anim_texture.flip_h = velocity.x > 0
	
	var direction = get_player_direction()
	
	if run_from_player():
		direction *= -1
	
	velocity = direction * speed
	move_and_slide()

func knockback() -> void:
	print("Pra trás")
	var direction = get_player_direction()
	
	velocity = -direction * speed * 10
	anim_texture.flip_h = velocity.x < 0
	move_and_slide()

func can_attack() -> bool:
	return attack_cooldown.is_stopped()

func start_cooldown() -> void:
	attack_cooldown.start()

func attack() -> void:
	player.get_hit(_damage)

func should_chase() -> bool:
	return global_position.distance_to(player.global_position) > attack_range and !run_from_player()

func should_attack() -> bool:
	return global_position.distance_to(player.global_position) < attack_range and !run_from_player()
	
func get_player_direction() -> Vector2:
	return (player.global_position - global_position).normalized()

func get_hit(amount: int) -> void:
	health -= amount
	
	if health <= 0:
		PlayerStats.set_xp(xp) 
		queue_free()

func run_from_player() -> bool:
	if got_hit:
		return true
	return global_position.distance_to(player.global_position) < flee_range
