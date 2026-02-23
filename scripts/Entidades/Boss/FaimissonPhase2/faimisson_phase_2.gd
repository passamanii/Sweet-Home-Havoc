extends Node2D

@export var stones_container: Node2D
@export var stones_scene: Array[PackedScene]
@export var shield: Area2D
@export var orbit_increase_speed: int = 1000
@export var orbit_shrink_speed: int = 400
@export var blay_blade_speed: int = 300

var stones = []
var orbit_radius = 300.0
var rotation_speed = 1.0
var current_angle = 0.0
var player: BasePlayer
var expand_orbit_mode: bool = false
var expanding: bool = false
var expanding_preparation: bool = false
var prepare_expand_time: float = 0
var shrinking: bool = false

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
#       BlayBlade       #
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
	
	await get_tree().create_timer(10).timeout
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
