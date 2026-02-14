extends Node2D


func on_Enter_Sala_Faimisson_body_entered(body: Node2D) -> void:

	if (body.is_in_group('Player')):

		get_tree().change_scene_to_file('res://scenes/Mapas/Sala_Faimisson.tscn')
		
