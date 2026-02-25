extends Node2D

@export var damage_popup: PackedScene
@export var anim_sprite: AnimatedSprite2D
@export var laser_pivot: Node2D
@export var laser: Area2D
@export var laser_collision: CollisionShape2D
@export var laser_damage: int = 1

var health: float = 50
var shield_on: bool = true
var broken: bool = false
var player: BasePlayer

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")

func _physics_process(_delta: float) -> void:
	rotation = Vector2.RIGHT.angle()

func set_laser_rotation(boss_position: Vector2):
	laser_pivot.rotation = boss_position.direction_to(global_position).angle()

func start_laser():
	laser.visible = true
	laser.monitoring = true

func stop_laser():
	laser.visible = false
	laser.monitoring = false

func get_hit() -> void:
	if shield_on:
		return
	
	var popup = damage_popup.instantiate()
	popup.text = str(Player_Stats.damage)
	popup.global_position = global_position + Vector2(-50, -25)
	get_tree().current_scene.add_child(popup)
	
	health -= Player_Stats.damage
	
	if health <= 0:
		anim_sprite.play("Broken")
		broken = true

func _on_hitbox_area_area_entered(_area: Area2D) -> void:
	get_hit()

func _on_laser_area_area_entered(_area: Area2D) -> void:
	var laser_dir = (laser_collision.global_position - global_position).normalized()
	
	var to_player = player.global_position - global_position
	
	var side = to_player.dot(laser_dir.orthogonal())
	
	var knockback_dir = laser_collision.global_transform.y.normalized()
	
	if side > 0:
		knockback_dir = -knockback_dir
	
	player.get_hit(laser_damage, knockback_dir, 2000)
