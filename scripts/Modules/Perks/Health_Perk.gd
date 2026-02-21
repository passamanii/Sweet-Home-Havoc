class_name HealthPerk extends BasePerk

@export var health_bonus: int = 10

func apply_perk() -> void:
	Player_Stats.max_health += health_bonus
