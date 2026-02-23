extends State

@export var boss_body: Faimisson2

func Enter() -> void:
	await get_tree().create_timer(1).timeout
	await boss_body.do_air_punchs()
	
	Transitioned.emit(self, "DomainExpansion")

func Update(_delta: float):
	if boss_body.punch_mode:
		var to_target = boss_body.punch_target - boss_body.global_position
		
		if to_target.dot(boss_body.dir) <= 0:
			boss_body.punch_mode = false
			boss_body.velocity = Vector2.ZERO
			boss_body.position = Vector2.ZERO
			boss_body.start_punch()
			
		boss_body.move_and_slide()
