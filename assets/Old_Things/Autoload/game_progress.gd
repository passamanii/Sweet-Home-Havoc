extends Node

var time_minutes: int = 0
var hours: int
var minutes: int

const REAL_SECONDS_PER_TICK := 5.0
const GAME_MINUTES_PER_TICK := 5

signal time_changed(hours: int, minutes: int)
signal time_finished

var _timer: Timer
var paused := false 

func _ready():
	_timer = Timer.new()
	_timer.wait_time = REAL_SECONDS_PER_TICK
	_timer.one_shot = false
	add_child(_timer)
	_timer.timeout.connect(_on_timer_timeout)

func start(hour: int, minute: int) -> void:
	time_minutes = hour * 60 + minute
	emit_time()
	paused = false
	_timer.start()

func pause() -> void:
	if paused:
		return
	paused = true
	_timer.paused = true

func resume() -> void:
	if not paused:
		return
	paused = false
	_timer.paused = false

func stop() -> void:
	paused = false
	_timer.stop()

func _on_timer_timeout() -> void:
	time_minutes -= GAME_MINUTES_PER_TICK
	time_minutes = max(time_minutes, 0)
	emit_time()

	if time_minutes <= 0:
		_timer.stop()
		emit_signal("time_finished")

func emit_time() -> void:
	hours = time_minutes / 60
	minutes = time_minutes % 60
	emit_signal("time_changed", hours, minutes)
