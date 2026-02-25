extends BaseColectionItem

func _ready() -> void:
	if CollectionController.cheese:
		mysterious_item.hide()
		collection_item.texture = load("res://assets/Collectables/cheese.png")
		collection_item.show()
	else:
		return
		
