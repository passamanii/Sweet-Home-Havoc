extends ProjectileBase

@export var anim_sprite: AnimatedSprite2D

var warn

func _ready() -> void:
	target = get_tree().get_first_node_in_group("Player")
	
	dir = global_position.direction_to(warn.global_position)

func _physics_process(delta: float) -> void:
	var velocity = dir * speed
	global_position += velocity * delta
	
	if (global_position.y >= warn.global_position.y):
		warn.monitoring = true
		anim_sprite.play("Hits")
		await anim_sprite.animation_finished
		queue_free()
		warn.queue_free()
