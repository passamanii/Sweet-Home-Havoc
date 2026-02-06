extends State

@onready var spawn_delay_timer: Timer = $SpawnDelay

var spawn: bool = true
var spawn_delay: float

func Enter() -> void:
	enemy.animation_tree.set("parameters/conditions/idle", false)
	enemy.animation_tree.set("parameters/conditions/sit", true)
	enemy.animation_tree.set("parameters/conditions/t_pose", false)
	
	spawn = true
	enemy.ant_timer.start()

func Update(_delta) -> void:
	if spawn:
		if spawn_delay_timer.is_stopped():
			spawn_delay_timer.wait_time = randf_range(0.2, 1.8)
			spawn_delay_timer.start()
		return
	
	if enemy.get_tree().get_first_node_in_group("Ants"):
		return
	
	Transitioned.emit(self, "tongue")

func _on_ants_timer_timeout() -> void:
	spawn = false

func _on_spawn_delay_timeout() -> void:
	enemy.spawn_ants()
