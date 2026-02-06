extends Area2D
class_name ThrowableBase

@export_category("Variables")
@export var damage: int = 10
@export var speed: int = 500

var target: Vector2
var direction: Vector2

func _physics_process(delta: float) -> void:
	move(delta)
	
func move(delta) -> void:
	position += direction * speed * delta

func set_direction(body_position: Vector2) -> void:
	target = body_position
	direction = (target - global_position).normalized()
	$destructionTimer.start()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.get_hit(damage)
		queue_free()

func _on_destruction_timer_timeout() -> void:
	queue_free()
