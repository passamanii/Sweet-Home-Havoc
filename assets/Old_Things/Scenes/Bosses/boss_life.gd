extends Control

@export var progress_bar: ProgressBar

var boss: BossBase

func _ready() -> void:
	boss = get_tree().get_first_node_in_group("Boss")
	if boss:
		progress_bar.max_value = boss.max_health

func _process(_delta: float) -> void:
	if boss:
		progress_bar.value = boss.health
	else:
		progress_bar.value = 0
		set_process(false)
