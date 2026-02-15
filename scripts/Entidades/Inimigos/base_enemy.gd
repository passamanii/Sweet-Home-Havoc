extends CharacterBody2D
class_name BaseEnemy

@export_category("Objects")
@export var sprite_2d: Sprite2D
@export var anim_player: AnimationPlayer
@export var enemy_collision: CollisionShape2D
@export var hurtbox_area: Area2D
@export var hitbox_area: Area2D
@export var attack_cooldown: Timer

@export_category("Variables")
@export var max_health: int
@export var damage: int
@export var speed: int
@export var chase_range: int
@export var attack_range: int
@export var xp_amount: int

var health: int
var target: BasePlayer

func _ready() -> void:
	health = max_health
	target = get_tree().get_first_node_in_group("Player")

func move() -> void:
	var dir: Vector2 = self.position.direction_to(target.position)
	velocity = dir * speed
	
	if (dir.x > 0):
		sprite_2d.flip_h = true
	else:
		sprite_2d.flip_h = false
	
	move_and_slide()

func attack() -> void:
	hitbox_area.monitoring = true
	print("TOMA")

func can_chase() -> bool:
	if (self.position.distance_to(target.position) <= chase_range and !is_in_attack_range()):
		return true
	else:
		return false

func is_in_attack_range() -> bool:
	if (self.position.distance_to(target.position) <= attack_range):
		return true
	else:
		return false

func can_attack() -> bool:
	if (is_in_attack_range() and attack_cooldown.is_stopped()):
		return true
	else:
		return false

func start_cooldown() -> void:
	print("ataque")
	attack_cooldown.start()

func die() -> void:
	print("Morreu: ", self.name)
	pass

func _on_anim_player_animation_finished(anim_name: StringName) -> void:
	if (anim_name == "Attacking"):
		hitbox_area.monitoring = false
