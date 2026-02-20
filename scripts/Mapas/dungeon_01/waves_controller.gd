extends Node

@export_category("Objects")
@export var wave_label: Label
@export var time_left_label: Label
@export var spawner_controller: Node
@export var cutscene_manager: Node

var seconds_left: int = 60
var actual_wave: int = 1

signal finished_dungeon_01(win: bool)

func format_time() -> String:
	if seconds_left == 60:
		return "1:00"
	
	return "0:" + str(seconds_left).lpad(2, "0")

func wave_finished() -> void:
	seconds_left = 60
	spawner_controller.pause()
	for enemy in get_tree().get_nodes_in_group("Enemy"):
		enemy.queue_free()
	actual_wave += 1
	wave_label.text = "Wave " + str(actual_wave)
	spawner_controller.start()

func win() -> void:
	spawner_controller.pause()
	for enemy in get_tree().get_nodes_in_group("Enemy"):
		enemy.queue_free()
	emit_signal("finished_dungeon_01", true)

func _on_spawn_timer_timeout() -> void:
	seconds_left -= 1
	if (seconds_left < 0 and actual_wave >= 5):
		win()
		time_left_label.text = "0:00"
		return
	elif (seconds_left < 0):
		wave_finished()
		
	time_left_label.text = format_time()
