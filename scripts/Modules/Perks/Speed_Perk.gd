class_name SpeedPerk extends BasePerk

@export var speed_boost: int = 50

func apply_perk():
	Player_Stats.speed += speed_boost
