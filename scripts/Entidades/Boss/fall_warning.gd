extends Area2D

var target: BasePlayer
var naranja

func _ready() -> void:
	target = get_tree().get_first_node_in_group("Player")

func _on_area_entered(_area: Area2D) -> void:
	print("Adentrou")
	target.get_hit(naranja.damage, global_position)
