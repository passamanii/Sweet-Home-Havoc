extends Node2D
class_name Faimisson2Head

@export var stones_container: Node2D
@export var stones_scene: Array[PackedScene]
@export var enemy_for_spawner: PackedScene
@export var red_stone_projectiles: PackedScene
@export var purple_barrier_area: Area2D
@export var purple_barrier_collision: CollisionShape2D
@export var purple_barrier_safe_area: Area2D
@export var purple_barrier_safe_collision: CollisionShape2D
@export var purple_barrier_safe_sprite: Sprite2D
@export var purple_barrier_sprite: AnimatedSprite2D
@export var shield: Area2D
@export var shield_sprite: AnimatedSprite2D
@export var boss_body: Faimisson2
@export var orbit_increase_speed: int = 1000
@export var orbit_shrink_speed: int = 400
@export var blay_blade_speed: int = 300
@export var purple_barrier_shrink_speed: int = 100
@export var purple_barrier_initial_radius: int = 1500

var stones = []
var orbit_radius = 300.0
var rotation_speed = 0.5
var current_angle = 0.0
var player: BasePlayer
var expand_orbit_mode: bool = false
var expanding: bool = false
var expanding_preparation: bool = false
var prepare_expand_time: float = 0
var shrinking: bool = false
var safe_from_purple_barrier: bool = false
var is_out_from_purple_area: bool = false

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	spawn_stones()

func _physics_process(delta: float) -> void:
	current_angle += rotation_speed * delta
	
	var step = TAU / stones.size()
	for i in stones.size():
		var angle = current_angle + step * i
		var offset = Vector2(cos(angle), sin(angle)) * orbit_radius
		stones[i].global_position = global_position + offset
		
	var scale_factor = orbit_radius / 300
	shield_sprite.scale = Vector2.ONE * scale_factor

func spawn_stones():
	for i in 3:
		var stone = stones_scene[i].instantiate()
		stones_container.add_child(stone)
		stones.append(stone)

func stones_attack():
	for stone in stones:
		if !stone.broken:
			stone.anim_sprite.play("Attacking")

func stones_idle():
	for stone in stones:
		if !stone.broken:
			stone.anim_sprite.play("Idle")

#########################
#      PURPLE STONE     #
#########################

func start_purple_barrier() -> void:
	purple_barrier_collision.shape.radius = purple_barrier_initial_radius
	spawn_safe_zone()
	purple_barrier_area.monitoring = true
	safe_from_purple_barrier = false
	is_out_from_purple_area = false
	purple_barrier_sprite.show()
	purple_barrier_safe_sprite.show()


func spawn_safe_zone() -> void:
	var pos = purple_barrier_initial_radius * Vector2.RIGHT.rotated(randf_range(0, 2 * PI))
	purple_barrier_safe_area.global_position = pos
	var dir_to_safezone = purple_barrier_area.global_position.direction_to(purple_barrier_safe_area.global_position)
	purple_barrier_safe_area.rotation = dir_to_safezone.angle() + deg_to_rad(90)

func _on_purpler_barrier_area_exited(area: Area2D) -> void:
	if !safe_from_purple_barrier and area.get_parent().is_in_group("Player"):
		player.get_hit(1, (global_position - player.global_position).normalized(), 2000)
	if safe_from_purple_barrier and !is_out_from_purple_area:
		is_out_from_purple_area = true

func _on_purpler_barrier_area_entered(area: Area2D) -> void:
	if is_out_from_purple_area and !safe_from_purple_barrier and area.get_parent().is_in_group("Player"):
		player.get_hit(1, (global_position - player.global_position).normalized(), 2000)
	
	is_out_from_purple_area = false

func _on_safe_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		safe_from_purple_barrier = true

func _on_safe_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		safe_from_purple_barrier = false

#########################
#        RED STONE       #
#########################

func start_following_attack() -> void:
	var quantity = 12
	
	for i in range(quantity):
		var projectile: ProjectileBase = red_stone_projectiles.instantiate()
		projectile.global_position = global_position + 800 * Vector2.RIGHT.rotated(deg_to_rad(i * (360./quantity)))
		projectile.initial_dir = Vector2.RIGHT.rotated(deg_to_rad(i * (360./quantity))).normalized()
		get_tree().current_scene.add_child(projectile)
		
#########################
#       BLUE STONE      #
#########################

func spawn_enemies() -> void:
	for i in range(25):
		var enemy: BaseEnemy = enemy_for_spawner.instantiate()
		enemy.global_position = global_position + 500 * Vector2.RIGHT.rotated(deg_to_rad(i * (360./25.)))
		get_tree().current_scene.add_child(enemy)
		
#########################
#       BLAY BLADE      #
#########################

func move(delta) -> void:
	var dir = global_position.direction_to(player.global_position)
	position += dir * blay_blade_speed * delta

########################
#     STONES LASER     #
########################

func start_stones_laser() -> bool:
	for stone in stones:
		stone.start_laser()
	
	await get_tree().create_timer(2).timeout
	return true

#########################
#    DOMAIN EXPANSION   #
#########################
func shrink_orbit(delta: float) -> void:
	orbit_radius -= delta * orbit_shrink_speed
	
	var collision = shield.get_children()[0] as CollisionShape2D
	collision.shape.radius = orbit_radius / 3.8
	
	if orbit_radius <= 300:
		expand_orbit_mode = false

func expand_orbit(delta: float) -> void:
	orbit_radius += delta * orbit_increase_speed
	
	var collision = shield.get_children()[0] as CollisionShape2D
	collision.shape.radius = orbit_radius / 3.8
	
	if orbit_radius >= 1500:
		expanding = false
		shrinking = true

func prepare_to_expand(delta: float) -> void:
	prepare_expand_time += delta
	
	if expanding_preparation:
		orbit_radius += delta * orbit_increase_speed
		if orbit_radius >= 400:
			expanding_preparation = false
	else:
		orbit_radius -= delta * orbit_increase_speed
		if orbit_radius <= 300:
			expanding_preparation = true
	
	if prepare_expand_time >= 2:
		expanding = true
		prepare_expand_time = 0

func start_expand_orbit() -> void:
	expand_orbit_mode = true

func _on_shieldd_area_area_entered(_area: Area2D) -> void:
	player.get_hit(0, (player.position - shield.position).normalized(), 1500)
