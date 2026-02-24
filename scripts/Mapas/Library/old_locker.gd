extends StaticBody2D

@onready var old_locker_interact: Interaction_With = $OldLockerInteract
@onready var player: BasePlayer = $"../../../Player"
@onready var locker_code: CanvasLayer = $"../../../LockerCodeCanvas"


func _ready() -> void:
	old_locker_interact.interact = _interact

func _interact() -> void:
	player.animation_player.play("Idle_Back")
	locker_code.show()
	player.can_move = false
