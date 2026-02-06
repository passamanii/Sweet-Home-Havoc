extends BaseSkillStrategy
class_name ActivatableSkillStrategy

@export var cooldown: float
@export var revert_timer: float
var can_use: bool = true

func activate() -> void:
	pass

func revert() -> void:
	pass
