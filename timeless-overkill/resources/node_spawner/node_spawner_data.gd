@tool
extends ShareableResource

class_name NodeSpawnerData

@export var spawns_cantity := LimitedValue.new()
@export var cooldown := 1.0:
	set(value):
		
		if cooldown == value:
			return
		
		cooldown = value
		changed.emit()

@export var max_node_at_a_time := 1
@export var can_spawn := true:
	set(value):
		
		if value == can_spawn:
			return
		
		can_spawn = value
		changed.emit()

## null if don't use node
@export var default_node_to_spawn: PackedScene
