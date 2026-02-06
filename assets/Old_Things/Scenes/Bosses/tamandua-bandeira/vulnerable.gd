extends State

@onready var vulnerable_timer: Timer = $VulnerableTimer

func Enter() -> void:
	enemy.animation_tree.set("parameters/conditions/idle", false)
	enemy.animation_tree.set("parameters/conditions/vulnerable", true)
	enemy.animation_tree.set("parameters/conditions/sit", false)
	enemy.animation_tree.set("parameters/conditions/t_pose", false)
	
	vulnerable_timer.start()

func Exit() -> void:
	enemy.can_hit = false
	enemy.animation_tree.set("parameters/conditions/vulnerable", false)
	
func _on_vulnerable_timer_timeout() -> void:
	Transitioned.emit(self, "idle")
