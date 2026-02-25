extends TextureRect

@onready var interact_with: Interaction_With = $InteractWith
@onready var panel: TextureRect = $Panel
var interacted: bool = false

func _ready() -> void:
	interact_with.interact = _on_interaction
	if CollectionController.interacted:
		panel.visible = false
		interact_with.is_interactible = false
	
func _on_interaction():
	CollectionController.cheese = true
	CollectionController.cigarette = true
	CollectionController.book = true
	CollectionController.girl_teardrop = true
	CollectionController.grass = true
	CollectionController.him = true
	CollectionController.nugget = true
	CollectionController.orange = true
	CollectionController.pen = true
	CollectionController.yellow_ball = true
	
	CollectionController.interacted = true
	panel.visible = false
	interact_with.is_interactible = false
	interact_with._on_body_exited($InteractWith/CollisionShape2D)
