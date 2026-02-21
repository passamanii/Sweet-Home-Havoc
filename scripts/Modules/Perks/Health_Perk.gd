class_name HealthPerk extends BasePerk

@export var health_bonus: int = 10
var base_perk: BasePerk

func apply_perk() -> void:
	if base_perk.level == 1:
		Player_Stats.max_health += health_bonus
	elif base_perk.level == 2:
		Player_Stats.max_health += 2*health_bonus
	elif base_perk.level == 3:
		Player_Stats.max_health += 3 * health_bonus
	print('Vida do player: ', Player_Stats.max_health)
	
