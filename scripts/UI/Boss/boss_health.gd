extends CanvasLayer

@export var boss: Faimisson1 
@export var bar: TextureProgressBar

func _ready() -> void:
	if boss == null:
		self.hide()
		return
	bar.max_value = boss.max_health
	bar.value = boss.health
	boss.updated_health.connect(_on_updated_health)

func _on_updated_health() -> void:
	bar.value = boss.health
