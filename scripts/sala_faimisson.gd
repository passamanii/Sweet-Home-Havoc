extends Node2D

var k: int = 0

func _ready() -> void:
	
	$Player/AnimationPlayer.play('Idle_Right')
	k = 1
	
func _on_area_2d_body_entered(body: Node2D) -> void:

	if (k == 0):
		
		if (body.is_in_group('Player')):
			
			get_tree().change_scene_to_file("res://scenes/Mapas/Main_Mapa.tscn")


func _on_area_2d_body_exited(body: Node2D) -> void:
	
	if (body.is_in_group('Player')):
		
		k = 0
