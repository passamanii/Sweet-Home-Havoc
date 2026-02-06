extends Node2D

@export var speed := 60.0
@export var retract_speed := 700.0
@export var damage := 0.5

signal knockout

var target: CharacterBody2D

@onready var line: Line2D = $Line2D
@onready var area: Area2D = $Area2D

enum State { GROWING, RETRACTING }
var state := State.GROWING
var is_hurting: bool = false

var direction := Vector2.RIGHT
var head_pos := Vector2.ZERO

var segments: Array[CollisionShape2D] = []

func _ready():
	target = get_tree().get_first_node_in_group("Player")

	line.clear_points()
	head_pos = Vector2.ZERO
	line.add_point(head_pos)

func _process(_delta):
	if target == null:
		return
		
	if is_hurting:
		target.get_hit(damage)

func grow(delta):
	choose_direction()

	var previous_pos := head_pos
	head_pos += direction * speed * delta

	line.add_point(head_pos)
	add_collision_segment(previous_pos, head_pos)

func retract(delta):
	var steps := int(retract_speed * delta)

	for i in steps:
		if line.points.size() <= 1:
			queue_free()
			return

		line.remove_point(line.points.size() - 1)

		var seg = segments.pop_back()
		if seg:
			seg.queue_free()

	head_pos = line.points[line.points.size() - 1]

func choose_direction():
	var target_pos := to_local(target.global_position)
	var diff := target_pos - head_pos

	if abs(diff.x) > abs(diff.y):
		direction = Vector2(sign(diff.x), 0)
	else:
		direction = Vector2(0, sign(diff.y))

func add_collision_segment(p1: Vector2, p2: Vector2):
	var distance := p1.distance_to(p2)
	if distance < 0.1:
		return

	var shape := RectangleShape2D.new()
	shape.size = Vector2(distance, line.width)

	var col := CollisionShape2D.new()
	col.shape = shape
	col.position = (p1 + p2) * 0.5
	col.rotation = (p2 - p1).angle()

	area.add_child(col)
	segments.append(col)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_hurting = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_hurting = false

func _on_tree_exited() -> void:
	knockout.emit()
