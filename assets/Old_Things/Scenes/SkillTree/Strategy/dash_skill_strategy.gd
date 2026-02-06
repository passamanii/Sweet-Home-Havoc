extends ActivatableSkillStrategy
class_name DashSkillStrategy

@export var dash_force: float

func activate() -> void:
	PlayerStats.speed_multiplier *= dash_force

func revert() -> void:
	PlayerStats.speed_multiplier /= dash_force
