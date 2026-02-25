extends BaseColectionItem

func _ready() -> void:
	if CollectionController.cigarette:
		mysterious_item.hide()
		collection_item.texture = load("res://assets/Collectables/cigarrete.png")
		collection_item.show()
	else:
		return
		
