extends BaseColectionItem

func _ready() -> void:
	if CollectionController.pen:
		mysterious_item.hide()
		collection_item.texture = load("res://assets/Collectables/pen.png")
		collection_item.show()
	else:
		return
		
