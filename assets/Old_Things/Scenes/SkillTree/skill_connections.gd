extends Control

@export var connections: Dictionary[String, Array]
# Called when the node enters the scene tree for the first time.
func _draw() -> void:
	for from_id in connections:
		var from_btn = get_parent().get_node(from_id) as Control
		if not from_btn:
			continue
		
		for to_id in connections[from_id]:
			var to_btn = get_parent().get_node(to_id) as Control
			if not to_btn or to_btn.visible == false:
				continue
			
			draw_line(
				from_btn.position + from_btn.size / 2,
				to_btn.position + to_btn.size / 2,
				Color.WHITE,
				10
			)
