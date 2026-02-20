extends Control

@onready var label: Label = $"Menu_Brackground/Panel(Xp)/Label"

var base_txt: String = 'XP: '

func _process(_delta: float) -> void:
	update_xp_shown()
	
func update_xp_shown():
	label.text = base_txt + str(Player_Stats.spentable_xp)


func _on_saudável_mouse_entered() -> void:
	pass


func _on_fortão_mouse_entered() -> void:
	pass # Replace with function body.
