class_name RegenPerk extends BasePerk

@export var regen_bonus: float = 1.2

func _init() -> void:
	level = Skills_Stats.skills_levels['RegenPerk']
	
func get_type() -> String:
	return 'regen'
	
func apply_perk() -> void:
	#integrar função de regen
	if Skills_Stats.skills_levels['RegenPerk'] < 3:
		Skills_Stats.skills_levels['RegenPerk'] += 1
		_init()
