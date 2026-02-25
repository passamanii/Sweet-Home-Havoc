extends Node2D

@onready var dialog_ui: Control = $DialogUI

var npc: Node = null

func show_dialog(speaker, text = "", options = {}):
	if text != "":
		if speaker == "Aluno":
			dialog_ui.show_dialog(Player_Stats.pname, text, options)
		else:
			dialog_ui.show_dialog(speaker, text, options)
	else:
		var dialog = npc.get_current_dialog()
		if dialog == null:
			return
		if dialog["speaker"] == "Aluno":
			dialog_ui.show_dialog(Player_Stats.pname, dialog["text"], dialog["options"])
		else:
			dialog_ui.show_dialog(dialog["speaker"], dialog["text"], dialog["options"])
	
func hide_dialog():
	dialog_ui.hide_dialog()

func handle_dialog_choice(option):
	var current_dialog = npc.get_current_dialog()
	if current_dialog == null:
		return
	
	var next_state = current_dialog["options"].get(option, "start")
	npc.set_dialog_state(next_state)
	
	if next_state == "end":
		if npc.dialog_info["current_branch_index"] < npc.dialog_resource.get_npc_dialog(npc.npc_id).size() - 1:
			npc.set_dialog_tree(npc.dialog_info["current_branch_index"] + 1)
		hide_dialog()
	elif next_state == "exit":
		hide_dialog()
		npc.set_dialog_state("start")
	elif next_state == "quit":
		get_tree().quit()
	else:
		show_dialog(current_dialog["speaker"])
	
