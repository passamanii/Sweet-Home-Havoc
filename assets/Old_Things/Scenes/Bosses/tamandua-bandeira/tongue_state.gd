extends State

enum State { GROWING, RETRACTING }
var curr_state := State.GROWING

func Enter() -> void:
	enemy.animation_tree.set("parameters/conditions/idle", false)
	enemy.animation_tree.set("parameters/conditions/sit", true)
	enemy.animation_tree.set("parameters/conditions/t_pose", false)
	
	curr_state = State.GROWING
	
	if enemy.tongue:
		enemy.tongue.queue_free()
		
	enemy.tongue = enemy.TONGUE.instantiate()
	enemy.start_tongue()

func Update(delta: float) -> void:
	if enemy.can_hit:
		Transitioned.emit(self, "vulnerable")
		return
	
	match curr_state:
		State.GROWING:
			enemy.grow_tongue(delta)
		State.RETRACTING:
			enemy.retract_tongue(delta)

func Exit() -> void:
	pass
	
func _on_tongue_timer_timeout() -> void:
	curr_state = State.RETRACTING
	
