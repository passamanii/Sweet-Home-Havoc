extends CharacterBody2D
class_name BossBase

@export_category("Variables")
@export var max_health: int
@export var speed: int

@export_category("Base Objects")
@export var animation_tree: AnimationTree

var can_hit = false
var got_hit = false
var health: int
var player: CharacterBody2D

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	health = max_health

func get_hit(amount: int) -> void:
	if can_hit:
		health -= amount
	
		if health <= 0:
			queue_free()
