class_name SpeedPerk extends BasePerk

@export var speed_boost: int = 50

func _init() -> void:
	level = Skills_Stats.skills_levels['SpeedPerk']
	
func get_type() -> String:
	return 'speed'
	
func apply_perk():
	Player_Stats.speed += speed_boost
	if Skills_Stats.skills_levels['SpeedPerk'] < 3:
		Skills_Stats.skills_levels['SpeedPerk'] += 1
		_init()
