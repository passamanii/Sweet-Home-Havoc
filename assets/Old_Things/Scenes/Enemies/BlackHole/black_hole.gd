extends ThrowerEnemy

@export_category("Objects")
@export var attack_origin_2: Marker2D
@export var attack_origin_3: Marker2D

var shots_left: int = 3
var attack_positions: Array[Marker2D]

func _ready() -> void:
	super()
	attack_positions = [attack_origin_3, attack_origin_2, attack_origin]

func attack() -> void:
	while shots_left > 0:
		var direction = get_player_direction()
		anim_texture.flip_h = direction.x > 0
		for marker: Marker2D in attack_positions:
			if marker.position.x < 0:
				marker.position *= -1 if direction.x < 0 else 1
			elif marker.position.x > 0:
				marker.position *= -1 if direction.x > 0 else 1
	
		var throwable = throwable_scene.instantiate()
		get_parent().add_child(throwable)
	
		throwable.global_position = attack_positions[shots_left - 1].global_position
		throwable.set_direction(player.global_position)
		shots_left -= 1
		await get_tree().create_timer(0.4).timeout

func reload() -> void:
	shots_left = 3
