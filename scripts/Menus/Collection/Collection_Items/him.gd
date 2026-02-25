extends BaseColectionItem

func _ready() -> void:
	if CollectionController.him:
		mysterious_item.hide()
		collection_item.texture = load("res://assets/Collectables/him.png")
		collection_item.show()
	else:
		return
		
