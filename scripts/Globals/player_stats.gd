extends Node

var xp: int = 0
var spentable_xp: int = xp
var level: int = 1
var health: int = 30 #Cada coração equivale à 10hp
var max_health: int = health
var armor: int = 0
var damage: float = 10 
var level_requirement: Array = [0, 100, 300, 600, 800, 1000, 1200, 1400, 1600, 2000]
var speed: int = 450

func gain_xp(xp_amount) -> void:
	if (level != 10):
		xp += xp_amount
		spentable_xp += xp_amount * 2
		print('XP:', xp)

		if (xp >= level_requirement[level]):
			level += 1
			damage += 1.2 * level
			
			if (level % 2 == 0):
				health += 10
				max_health += 10
			
		print('Nível:', level)
		print('Dano:', damage)
		print('HP:', health)
	
