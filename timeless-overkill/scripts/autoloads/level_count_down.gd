extends Node

signal time_ended

## In seconds
const INITIAL_TIME := 60

@onready var _timer: Timer = Timer.new()
@export var phases: Array[Resource] = []

var time_left: float:
	get: return _timer.time_left

func _ready() -> void:
	add_child(_timer)
	_timer.one_shot = true
	_timer.wait_time = INITIAL_TIME
	_timer.timeout.connect(_on_end_time)

func start_level() -> void:
	_timer.start()

func end_level() -> void:
	_timer.stop()

func _on_end_time() -> void:
	time_ended.emit()
