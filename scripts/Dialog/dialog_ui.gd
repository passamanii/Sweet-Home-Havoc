extends Control

@onready var panel: Panel = $CanvasLayer/Panel
@onready var dialog_speaker: Label = $CanvasLayer/Panel/DialogBox/DialogSpeaker
@onready var dialog_text: Label = $CanvasLayer/Panel/DialogBox/DialogText
@onready var dialog_options: HBoxContainer = $CanvasLayer/Panel/DialogBox/DialogOptions

func _ready():
	hide_dialog()

func show_dialog(speaker, text, options):
	panel.visible = true
	
	dialog_speaker.text = speaker
	dialog_text.text = text
	
	for option in dialog_options.get_children():
		dialog_options.remove_child(option)
	
	for option in options.keys():
		var button = Button.new()
		button.text = option
		button.add_theme_font_size_override("font_size", 20)
		button.pressed.connect(_on_option_selected.bind(option))
		dialog_options.add_child(button)

func _on_option_selected(option):
	get_parent().handle_dialog_choice(option)

func hide_dialog():
	panel.visible = false
	Player_Tracking.player.can_move = true
