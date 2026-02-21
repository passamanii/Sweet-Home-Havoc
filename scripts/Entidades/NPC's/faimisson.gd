extends Node2D

@onready var interact_with: Interaction_With = $InteractWith
@onready var upgrade_menu: Control = $"CanvasLayer(Upgrade)/UpgradeMenu"
var menu_open: bool = false

func _ready() -> void:
	$AnimationPlayer.play('Idle')
	interact_with.interact = _on_interact
	
func _on_interact():
	if menu_open == false:
		show_upgrade_menu()
	else:
		hide_upgrade_menu()
		set_physics_process(true)
	
func show_upgrade_menu():
	menu_open = true
	upgrade_menu.show()
	
func hide_upgrade_menu():
	menu_open = false
	upgrade_menu.hide()
	
	
