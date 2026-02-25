extends BaseColectionItem

func _ready() -> void:
	if CollectionController.nugget:
		mysterious_item.hide()
		collection_item.texture = load("res://assets/Collectables/nugget.png")
		collection_item.show()
	else:
		return
		
