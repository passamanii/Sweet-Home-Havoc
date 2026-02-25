extends BaseColectionItem

func _ready() -> void:
	if CollectionController.yellow_ball:
		mysterious_item.hide()
		collection_item.texture = load("res://assets/Collectables/yellow-ball.png")
		collection_item.show()
	else:
		return
		
