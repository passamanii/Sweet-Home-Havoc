class_name StrenghPerk extends BasePerk

@export var damage_boost: float = 10

func apply_perk():
	Player_Stats.damage += damage_boost
