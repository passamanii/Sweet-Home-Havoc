extends StaticBody2D

@onready var table_interact: Interaction_With = $TableInteract
@onready var player: BasePlayer = $"../../../Player"
@onready var fade_transition: FadeTransition = $"../../../Fade_Transition"


func _ready() -> void:
	table_interact.interact = _interact

func _interact() -> void:

	if Game_Controller.has_first_book:
		player.can_move = false
		print("Você se senta para estudar... mas começa a ter uma sensação ruim.")
		await get_tree().create_timer(1).timeout
		fade_transition.transition_end.connect(_on_transition_end)
		fade_transition.init()
	else:
		print("Preciso de um livro pra começar.")

func _on_transition_end() -> void:
	get_tree().change_scene_to_file("res://scenes/Mapas/Dungeon_01.tscn")
