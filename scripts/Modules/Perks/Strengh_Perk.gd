class_name StrenghPerk extends Node

@export var damage_boost: int = 10
var base_perk: BasePerk

func apply_perk():
	if base_perk.level == 1:
		Player_Stats.damage += damage_boost * 1
	if base_perk.level == 2:
		Player_Stats.damage += damage_boost * 2
	if base_perk.level == 3:
		Player_Stats.damage += damage_boost * 3
