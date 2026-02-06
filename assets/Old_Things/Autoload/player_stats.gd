extends Node

var speed_multiplier: float = 1
var base_damage_multiplier: float = 1

var max_health: float = 100
var health: float = 100
var max_happiness: float = 100
var happiness: float = 100
var happiness_regen_delay: int = 2
var happiness_regen_amount: float = 0.1

# SkillTree
var qi_points: int = 1
var all_unlocked_skills_id: Array[String]
var all_passive_skills: Array[BaseSkillStrategy]
var all_activatable_skills: Array[ActivatableSkillStrategy]

var equipped_skills: Dictionary[String, ActivatableSkillStrategy] = {
	"skill_1": null,
	"skill_2": null,
	"skill_3": null,
}

# level
signal xp_changed(curr_xp, to_next_level)

var level = 1
var xp = 0
var xp_to_next_level = 25

func set_xp(quantity: int) -> void:
	xp += quantity
	
	if xp >= xp_to_next_level:
		var rest = xp - xp_to_next_level
		level_up(rest)
		
	xp_changed.emit(xp, xp_to_next_level)

func level_up(rest) -> void:
	qi_points += 1
	level += 1
	xp = 0
	if rest:
		set_xp(rest)
	base_damage_multiplier += 1.01
	xp_to_next_level *= 1.05
	max_health *= 1.1
	health = max_health
	max_happiness *= 1.1
	happiness = max_happiness
