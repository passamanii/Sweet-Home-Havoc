class_name StrenghPerk extends BasePerk

@export var damage_boost: float = 10

func _init() -> void:
	level = Skills_Stats.skills_levels['StrenghPerk']
	
func get_type() -> String:
	return 'strengh'
	
func apply_perk():
	Player_Stats.damage += damage_boost
	if Skills_Stats.skills_levels['StrenghPerk'] < 3:
		Skills_Stats.skills_levels['StrenghPerk'] += 1
		_init()
