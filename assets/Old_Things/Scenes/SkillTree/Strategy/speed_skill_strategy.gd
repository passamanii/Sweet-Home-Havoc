extends BaseSkillStrategy
class_name SpeedSkillStrategy

@export var add_to_speed_multiplier: float = 1.1

func apply_skill() -> void:
	PlayerStats.speed_multiplier *= add_to_speed_multiplier
