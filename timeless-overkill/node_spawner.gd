@tool
extends Node2D

class_name NodeSpawner

@onready var timer: Timer = $Timer

## if null, spawn childs inside [NodeContainer] inside self
@export var container: Node:
	set(value):
		
		if not value:
			return
		
		container = value

@export var data: NodeSpawnerData
@export var spawn_method: BaseNodeSpawnMethod

var is_spawning: bool:
	get: return not timer.is_stopped() and not timer.paused

func _ready() -> void:
	
	if Engine.is_editor_hint():
		return
	
	data = data.duplicate(true)
	
	if not container:
		container = $NodeContainer
	
	if not data.changed.is_connected(_update_data):
		data.changed.connect(_update_data)
	
	if not timer.timeout.is_connected(_on_end_timer):
		timer.timeout.connect(_on_end_timer)
	
	_update_data()
	
	if data.default_node_to_spawn:
		container.add_child(data.default_node_to_spawn.instantiate())

func spawn() -> void:
	
	if Engine.is_editor_hint():
		return
	
	var new_node := spawn_method.create()
	new_node.global_position = self.global_position
	
	if new_node.has_method("_on_spawned"):
		new_node.call("_on_spawned", self)
	
	container.add_child(new_node)
	data.spawns_cantity.current_value += 1

func _update_data() -> void:
	
	if Engine.is_editor_hint():
		return
	
	timer.wait_time = data.cooldown
	timer.paused = !data.can_spawn

func _start_spawning() -> void:
	pass

func _on_end_timer() -> void:
	
	spawn()
	_can_spawn()
	
	if data.can_spawn:
		timer.start()

func _can_spawn() -> void:
	
	if container.get_child_count() == data.max_node_at_a_time:
		_toggle_spawn(false)
	elif data.spawns_cantity.current_value == data.spawns_cantity.max_value:
		_toggle_spawn(false)
	else:
		_toggle_spawn(true)

func _toggle_spawn(value: bool) -> void:
	data.can_spawn = value
	timer.paused = not data.can_spawn
