extends BossBase

const TONGUE = preload("uid://c4p64n0d70yq1")

@export_category("Objects")
@export var tongue_marker: Marker2D
@export var tongue_timer: Timer
@export var ANT: PackedScene
@export var ant_timer: Timer

@export_category("Variables")
@export var dash_speed := 1500.0
@export var dash_duration := 1.25

var dash_counts: int = 0
var dash_direction := Vector2.ZERO
var is_dashing := false
var tongue

func _physics_process(_delta):
	if is_dashing:
		move_and_slide()

func start_dash(target_pos: Vector2) -> void:
	dash_direction = (target_pos - global_position).normalized()
	velocity = dash_direction * dash_speed
	is_dashing = true

	await get_tree().create_timer(dash_duration).timeout
	stop_dash()

func stop_dash() -> void:
	is_dashing = false
	velocity = Vector2.ZERO

func start_tongue() -> void:
	self.add_child(tongue)
	tongue.global_position = tongue_marker.global_position
	tongue.connect("knockout", knockout)
	tongue_timer.start()
	
func grow_tongue(delta) -> void:
	tongue.grow(delta)
	
func retract_tongue(delta) -> void:
	if tongue:
		tongue.retract(delta)

func knockout():
	can_hit = true

func spawn_ants() -> void:
	var ant = ANT.instantiate()
	get_parent().add_child(ant)
	ant.global_position = Vector2(randi_range(20, 6380), randi_range(20, 6300))
	await get_tree().create_timer(randf_range(0.2, 1.8)).timeout
