class_name RegenPerk extends BasePerk

@export var regen_bonus: int = 5

func _init() -> void:
	level = Skills_Stats.skills_levels['RegenPerk']
	
func get_type() -> String:
	return 'regen'
	
func apply_perk() -> void:
	Player_Stats.regen += regen_bonus
	if Skills_Stats.skills_levels['RegenPerk'] < 3:
		Skills_Stats.skills_levels['RegenPerk'] += 1
		_init()
