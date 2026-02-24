extends CanvasLayer

@onready var heart_container: HFlowContainer = $Control/HFlowContainer

var hearts: Array[HeartUI] = []

func _ready() -> void:
	for child in heart_container.get_children():
		if child is HeartUI:
			hearts.append(child)
			child.visible = false

func update_hp(hp: int, max_hp: float):
	update_max_hp(max_hp)
	for i in hearts.size():
		update_heart(i, hp)
	
func update_max_hp(max_hp: float) -> void:
	var heart_count: int = roundi(max_hp / 10)
	for i in hearts.size():
		if i < heart_count:
			hearts[i].visible = true
		else:
			hearts[i].visible = false
	
func update_heart(index: int, hp: int) -> void:
	var hp_per_heart: int = 10
	var local_hp: int = hp - index * hp_per_heart
	if local_hp >= 10:
		hearts[index].value = 2
	elif local_hp >= 5:
		hearts[index].value = 1
	else:
		hearts[index].value = 0
	#var _value: int = clampi(hp - index * 10, 0, 2)
	#hearts[index].value = _value
