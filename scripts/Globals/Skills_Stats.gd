extends Node

var skills_levels: Dictionary = {
	'HealthPerk' : 0,
	'StrenghPerk' : 0,
	'SpeedPerk' : 0,
	'ArmorPerk' : 0,
	'RegenPerk' : 0
}

func get_level_for(perk: BasePerk):
	if perk is HealthPerk:
		return skills_levels['HealthPerk']
	if perk is StrenghPerk:
		return skills_levels['StrenghPerk']
	if perk is SpeedPerk:
		return skills_levels['SpeedPerk']
	if perk is ArmorPerk:
		return skills_levels['ArmorPerk']
	if perk is RegenPerk:
		return skills_levels['RegenPerk']
