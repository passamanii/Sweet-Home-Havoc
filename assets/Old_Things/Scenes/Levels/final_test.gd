extends Node2D

const TAMANDUA_BANDEIRA = preload("uid://bd7b6s8i30g8u")
const BOSS_LIFE = preload("uid://bkak8nbekq8i")

@export_category("Objects")
@export var _player: CharacterBody2D
@export var _hud: CanvasLayer
@export var boss_music: AudioStreamPlayer
@export var ground_impact: AudioStreamPlayer

var boss: CharacterBody2D
var boss_life: Control

func _ready():
	GameProgress.connect("time_finished", start_boss)
	GameProgress.stop()
	
	_player.happiness_changed.connect(_hud.set_happiness)
	_player.health_changed.connect(_hud.set_health)
	_player._anim_texture.play("side_idle")
	_player._anim_texture.flip_h = true
	
	boss = TAMANDUA_BANDEIRA.instantiate()
	boss_life = BOSS_LIFE.instantiate()
	start_boss()

func start_boss() -> void:
	_hud.show()

	boss_music.play()
	add_child(boss)
	add_child(boss_life)
	boss.global_position = Vector2(3260, -6000)

	var tween: Tween = create_tween()
	tween.tween_property(boss, "position", Vector2(3227, 2829), 0.3)
	tween.tween_callback(Callable(ground_impact, "play"))
