class_name Armor_Perk extends BasePerk

@export var defense_bonus: int = 10

func apply_perk() -> void:
	Player_Stats.defense += defense_bonus
