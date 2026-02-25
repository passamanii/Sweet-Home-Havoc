extends CharacterBody2D

@export var npc_id: String
@export var npc_name: String
@export var npc_skin: AnimatedSprite2D

@export var dialog_resource: Dialog
@onready var dialog_manager: Node2D = $DialogManager
@onready var physics_area: CollisionShape2D = $PhysicsArea
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var dialog_info = {
	"current_state" : "start",
	"current_branch_index" : 1
}

func _ready():
	dialog_resource.load_from_json("res://Resources/Dialog/dialog_data.json")
	dialog_manager.npc = self
	load_all_info()
	if npc_skin != null:
		load_sprite()
	set_shapes()

func start_dialog():
	var npc_dialogs = dialog_resource.get_npc_dialog(npc_id)
	if npc_dialogs.is_empty():
		return
	dialog_manager.show_dialog(self)

func get_current_dialog():
	var npc_dialogs = dialog_resource.get_npc_dialog(npc_id)
	if (dialog_info["current_branch_index"] < npc_dialogs.size()):
		for dialog in npc_dialogs[dialog_info["current_branch_index"]]["dialogs"]:
			if dialog["state"] == dialog_info["current_state"]:
				return dialog
	return null

func set_dialog_tree(branch_index):
	dialog_info["current_branch_index"] = branch_index
	dialog_info["current_state"] = "start"

func set_dialog_state(state):
	dialog_info["current_state"] = state

func set_shapes():
	var shape = RectangleShape2D.new()
	var size: Vector2
	var cposition: Vector2
	if npc_id == "bibliotecario":
		size.x = 61
		size.y = 40
		cposition.x = -20
		cposition.y = -4
		shape.set_size(size)
		physics_area.set_shape(shape)
		physics_area.set_position(cposition)
	elif npc_id == "faimisson":
		size.x = 36
		size.y = 75
		cposition.x = 7
		cposition.y = 7.5
		shape.set_size(size)
		physics_area.set_shape(shape)
		physics_area.set_position(cposition)

func load_sprite():
	animated_sprite_2d.sprite_frames = npc_skin.sprite_frames
	animated_sprite_2d.visible = true
	animated_sprite_2d.play("idle")

func load_all_info():
	match npc_id:
		"cutscene":
			dialog_info = NPC_Controller.cutscene
		"faimisson":
			dialog_info = NPC_Controller.faimisson
		"leonardo":
			dialog_info = NPC_Controller.leonardo
		"livro":
			dialog_info = NPC_Controller.livro
		"bibliotecaria":
			dialog_info = NPC_Controller.bibliotecaria
		"veterano":
			dialog_info = NPC_Controller.veterano

func save_all_info():
	match npc_id:
		"cutscene":
			NPC_Controller.cutscene = dialog_info
		"faimisson":
			NPC_Controller.faimisson = dialog_info
		"leonardo":
			NPC_Controller.leonardo = dialog_info
		"livro":
			NPC_Controller.livro = dialog_info
		"bibliotecaria":
			NPC_Controller.bibliotecaria = dialog_info
		"veterano":
			NPC_Controller.veterano = dialog_info
