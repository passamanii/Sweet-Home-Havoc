extends BaseSkillStrategy
class_name DamageSkillStrategy

@export var add_to_damage_multiplier: float = 1.1

func apply_skill() -> void:
	PlayerStats.base_damage_multiplier *= add_to_damage_multiplier
