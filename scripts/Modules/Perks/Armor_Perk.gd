class_name ArmorPerk extends BasePerk

@export var defense_bonus: int = 10

func _init() -> void:
	level = Skills_Stats.skills_levels['ArmorPerk']

func get_type() -> String:
	return 'armor'
	
func apply_perk() -> void:
	Player_Stats.defense += defense_bonus
	if Skills_Stats.skills_levels['ArmorPerk'] < 3:
		Skills_Stats.skills_levels['ArmorPerk'] += 1
		_init()
