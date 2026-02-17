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
@export var xp_amount: int

var health: int
var target: BasePlayer
var is_in_range: bool
var knockback_force: int = 1000
var knockback_decay: int = 3000
var knockback_velocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	health = max_health
	target = get_tree().get_first_node_in_group("Player")

func _physics_process(_delta: float) -> void:
	var separation = (target.position - position).length()
	if separation >= 1800:
		queue_free()

func move() -> void:
	if (knockback_velocity.length()) > 0:
		velocity = knockback_velocity
		move_and_slide()
		return
	
	var dir: Vector2 = self.position.direction_to(target.position)
	velocity = dir * speed
	
	if (dir.x > 0):
		sprite_2d.flip_h = true
	else:
		sprite_2d.flip_h = false
	
	move_and_slide()

func attack() -> void:
	if is_in_range:
		target.get_hit(damage, self.position)

func can_chase() -> bool:
	return self.position.distance_to(target.position) <= chase_range and !is_in_range

func can_attack() -> bool:
	return is_in_range and attack_cooldown.is_stopped()

func get_hit() -> void:
	var direction = (global_position - target.global_position).normalized()
	knockback_velocity = direction * knockback_force
	
	health -= Player_Stats.damage
	if (health <= 0):
		die()

func start_cooldown() -> void:
	attack_cooldown.start()

func apply_knockback(delta) -> void:
	knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, knockback_decay * delta)

func die() -> void:
	queue_free()

func _on_hitbox_area_area_entered(area: Area2D) -> void:
	if (area.get_parent().is_in_group("Player")):
		is_in_range = true

func _on_hitbox_area_area_exited(area: Area2D) -> void:
	if (area.get_parent().is_in_group("Player")):
		is_in_range = false

func _on_hurtbox_area_area_entered(area: Area2D) -> void:
	if (area.get_parent().is_in_group("Player")):
		get_hit()
