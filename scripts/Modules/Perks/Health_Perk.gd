class_name HealthPerk extends BasePerk

@export var health_bonus: int = 10

func _init() -> void:
	level = Skills_Stats.skills_levels['HealthPerk']
	
func get_type() -> String:
	return 'health'

func apply_perk() -> void:
	Player_Stats.max_health += health_bonus
	if Skills_Stats.skills_levels['HealthPerk'] < 3:
		Skills_Stats.skills_levels['HealthPerk'] += 1
		_init()
