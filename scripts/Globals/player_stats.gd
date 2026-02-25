extends Node

var player: BasePlayer
var pname: String = "Aluno"
var xp: int = 0
var temp_xp: int = 0
var spentable_xp: int = xp
var level: int = 1
var temp_level: int = 1
var health: int = 30 #Cada coração equivale à 10hp
var max_health: int = 30
var temp_max_health: int = 30
var damage: float = 10 
var temp_damage: float = 10
var armor: int = 0
var regen: int = 0
var level_requirement: Array = [0, 100, 300, 600, 800, 1000, 
1200, 1400, 1600, 2250]
var speed: int = 450

signal gained_xp(_xp)
signal gained_lvl(_lvl)
enum weapon {PEN, INK, JBL}
var weapen_equipped: weapon = weapon.PEN

func gain_xp(xp_amount) -> void:
	var leveled_up: bool = false
	if (level != 10):
		xp += xp_amount
		spentable_xp += xp_amount * 2
		emit_signal('gained_xp', xp_amount)
		
		while true:
			if (level < 10 and xp >= level_requirement[level]):
				level += 1
				damage += 1.2 * level
				leveled_up = true
				if level == 2 or level == 4 or level == 6:
					health += 5
					max_health += 5
			else:
				break
		if leveled_up:
			emit_signal('gained_lvl', level)
