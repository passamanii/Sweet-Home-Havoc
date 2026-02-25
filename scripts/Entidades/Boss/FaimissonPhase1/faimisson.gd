extends CharacterBody2D
class_name Faimisson1

@export_category("Variables")
@export var max_health: float
@export var dash_force: float = 2000.0
@export var dash_extra_distance: float = 300.0
@export var dash_brake_force: float = 3000.0
@export var damage: int = 1

@export_category("Objects")
@export var kick_marker: Marker2D
@export var supersonic_power_scene: PackedScene
@export var tornado_scene: PackedScene
@export var fall_warn_scene: PackedScene
@export var naranja_gigante_scene: PackedScene
@export var anim_tree: AnimationTree
@export var sprite: Sprite2D
@export var hitbox_area: Area2D
@export var hurtbox_area: Area2D
@export var health_bar: CanvasLayer
@export var warns: Node2D
@export var fade_transition: FadeTransition

var health: float
var player: BasePlayer
var dash: bool = false
var state_machine
var dash_velocity: Vector2 = Vector2.ZERO
var dash_target: Vector2
var dir: Vector2

signal updated_health(damage: float)

func _ready() -> void:
	state_machine = anim_tree.get("parameters/playback")
	player = get_tree().get_first_node_in_group("Player")
	health = max_health
	boss_cycle()

func _physics_process(delta: float) -> void:
	if dash:
		velocity = dash_velocity
		move_and_slide()

		var to_target = dash_target - global_position

		if to_target.dot(dir) <= 0:
			state_machine.travel("Dash_Brake")
			if dir.x > 0:
				sprite.flip_h = true
			elif dir.x < 0:
				sprite.flip_h = false
			dash_velocity = dash_velocity.move_toward(Vector2.ZERO, dash_brake_force * delta)

			if dash_velocity.length() < 10:
				dash = false
				velocity = Vector2.ZERO
				dash_velocity = Vector2.ZERO

func start_dash() -> void:
	state_machine.travel("Dash")
	dash = true
	
	var player_pos = player.global_position
	dir = global_position.direction_to(player_pos)

	if dir.x > 0:
		sprite.flip_h = false
	elif dir.x < 0:
		sprite.flip_h = true

	dash_target = player_pos + dir * dash_extra_distance

	dash_velocity = dir * dash_force

func throw_tornado() -> void:
	var quantity: int = 12
	
	for i in range(quantity):
		var tornado = tornado_scene.instantiate()
		var spawn_pos = global_position + 150 * Vector2.RIGHT.rotated((i * (TAU / quantity)))
		tornado.dir = Vector2(cos(i * (TAU / quantity)), sin(i * (TAU / quantity)))
		tornado.global_position = spawn_pos
		get_tree().current_scene.add_child(tornado)

func throw_supersonic_power() -> void:
	var supersonic_power = supersonic_power_scene.instantiate()
	supersonic_power.global_position = kick_marker.global_position
	get_tree().current_scene.add_child(supersonic_power)

func add_naranja_fall_warn() -> void:
	var fall_warn = fall_warn_scene.instantiate()
	var naranja_gigante = naranja_gigante_scene.instantiate()
	
	var warn_pos = global_position + randi_range(200, 1800) * Vector2.RIGHT.rotated(randf_range(0, TAU))
	fall_warn.global_position = warn_pos
	fall_warn.naranja = naranja_gigante
	warns.add_child(fall_warn)
	
	naranja_gigante.warn = fall_warn
	naranja_gigante.global_position = warn_pos - Vector2(0, 2000)
	get_tree().current_scene.add_child(naranja_gigante)

func do_kick() -> void:
	state_machine.travel("Kick")
	await get_tree().create_timer(7).timeout
	state_machine.travel("Idle")
	await get_tree().create_timer(2).timeout

func do_breath() -> void:
	state_machine.travel("Breath")
	await get_tree().create_timer(8).timeout
	state_machine.travel("Idle")
	await get_tree().create_timer(2).timeout

func do_dash() -> void:
	start_dash()
	# Dependendo da quantidade de tempo buga:
	await get_tree().create_timer(7).timeout
	state_machine.travel("Idle")
	dash = false
	velocity = Vector2.ZERO
	dash_velocity = Vector2.ZERO
	global_position = Vector2.ZERO
	await get_tree().create_timer(2).timeout

func do_naranjas() -> void:
	state_machine.travel("Naranjas")
	await get_tree().create_timer(8).timeout
	state_machine.travel("Idle")
	await get_tree().create_timer(2).timeout

func do_vulnerable() -> void:
	hitbox_area.monitoring = false
	hurtbox_area.monitoring = true
	health_bar.show()
	await get_tree().create_timer(5).timeout
	health_bar.hide()
	await get_tree().create_timer(1).timeout
	hitbox_area.monitoring = true
	hurtbox_area.monitoring = false

func boss_cycle():
	await get_tree().create_timer(2).timeout
	while true:
		await do_vulnerable()
		await do_breath()
		await do_dash()
		await do_kick()
		await do_naranjas()
		if health <= 0:
			break

func go_to_second_fase() -> void:
	fade_transition.init_white()
	fade_transition.transition_end.connect(_cabou)

func _cabou() -> void:
	get_tree().change_scene_to_file("res://scenes/Mapas/final_boss_room_02.tscn")

func _on_hitbox_area_area_entered(_area: Area2D) -> void:
	player.get_hit(damage, (player.global_position - global_position).normalized())

func get_hit() -> void:
	if hurtbox_area.monitoring:
		health -= Player_Stats.damage
		updated_health.emit()
		
		print(health)
		if health <= 0:
			
			go_to_second_fase()
			health_bar.hide()

func _on_hurtbox_area_entered(_area: Area2D) -> void:
	get_hit()
