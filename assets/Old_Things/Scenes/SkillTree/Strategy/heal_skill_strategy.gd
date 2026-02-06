extends ActivatableSkillStrategy
class_name HealSkillStrategy

func activate() -> void:
	PlayerStats.health = PlayerStats.max_health
