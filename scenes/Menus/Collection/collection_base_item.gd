class_name BaseColectionItem extends Control

@onready var mysterious_item: TextureRect = $Collection_Pedestal/Mysterious_Item
@onready var collection_item: TextureRect = $Collection_Pedestal/Collection_Item

func _ready() -> void:
	if CollectionController.col:
		mysterious_item.hide()
		collection_item.texture = load("res://assets/Collectables/col.png")
		collection_item.show()
	else:
		return
		
