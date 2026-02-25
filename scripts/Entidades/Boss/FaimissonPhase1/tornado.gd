extends ProjectileBase

var amplitude = 800.0
var frequency = 6.0
var time_passed = 0.0

func _ready() -> void:
	target = get_tree().get_first_node_in_group("Player")
	
	life_time_timer.wait_time = life_time
	life_time_timer.start()

func _physics_process(delta: float) -> void:
	time_passed += delta
	
	var perpendicular = Vector2(-dir.y, dir.x)
	var wave = sin(time_passed * frequency) * amplitude
	
	var velocity = dir * speed
	velocity += perpendicular * wave
	
	global_position += velocity * delta
