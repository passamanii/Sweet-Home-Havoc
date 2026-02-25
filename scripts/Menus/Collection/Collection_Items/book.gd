extends BaseColectionItem

func _ready() -> void:
	if CollectionController.book:
		mysterious_item.hide()
		collection_item.texture = load("res://assets/Collectables/book.png")
		collection_item.show()
	else:
		return
		
