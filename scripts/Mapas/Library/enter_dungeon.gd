extends Area2D

var is_in_area: bool

func _ready() -> void:
	is_in_area = false
	
	body_entered.connect(func(_body):
		print("Entrou")
		is_in_area = true
	)
	body_exited.connect(func(_body):
		is_in_area = false
	)

func _process(_delta: float) -> void:
	if self.is_in_area and Game_Controller.has_first_book:
		print("UAI")
		if Input.is_action_just_pressed("interact"):
			print("Você se senta para estudar... mas começa a ter uma sensação ruim.")
			await get_tree().create_timer(1).timeout
			get_tree().change_scene_to_file("res://scenes/Mapas/Dungeon_01.tscn")
