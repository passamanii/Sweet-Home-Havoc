extends BaseColectionItem

func _ready() -> void:
	if CollectionController.girl_teardrop:
		mysterious_item.hide()
		collection_item.texture = load("res://assets/Collectables/girl-teardrop.png")
		collection_item.show()
	else:
		return
		
