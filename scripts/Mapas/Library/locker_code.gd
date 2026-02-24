extends Control

@export var grid_btns: GridContainer
@onready var locker_visor: Label = $Panel/MarginContainer/VBoxContainer/MarginContainer/LockerVisor
@onready var cutscene_manager = $"../../CutsceneManager"

var digits: String

func _ready() -> void:
	for button in grid_btns.get_children():
		if button is Button:
			button.pressed.connect(_on_button_pressed.bind(button))

func _on_button_pressed(button: Button) -> void:
	print("Clicou")
	
	if button.text == "OK":
		print("Verificou")
		verify_password()
	elif button.text == "x":
		print("Apagou")
		digits = ""
		update_visor()
	else:
		if digits.length() >= 4:
			return
		digits += button.text
		update_visor()

func update_visor() -> void:
	locker_visor.text = digits.rpad(4, "0")

func verify_password() -> void:
	digits = digits.rpad(4, "0")
	
	print(digits)
	if digits == Game_Controller.locker_1_code:
		print("Abriu... Você encontrou um livro. Oque será que tem dentro dele?")
		cutscene_manager.open_locker_cutscene()
	else:
		print("Errou")

func _on_exit_btn_pressed() -> void:
	self.get_parent().hide()
	print(get_tree().get_first_node_in_group("Player"))
	get_tree().get_first_node_in_group("Player").set_physics_process(true)
