extends BaseColectionItem

func _ready() -> void:
	if CollectionController.grass:
		mysterious_item.hide()
		collection_item.texture = load("res://assets/Collectables/grass.png")
		collection_item.show()
	else:
		return
		
