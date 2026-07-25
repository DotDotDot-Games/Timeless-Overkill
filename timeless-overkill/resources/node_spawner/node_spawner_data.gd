@tool
extends ShareableResource

class_name NodeSpawnerData

## Defines the maximum number of nodes the spawn can invoke.
@export var spawns_cantity: LimitedValue
@export var cooldown := 1.0:
	set(value):
		
		if cooldown == value:
			return
		
		cooldown = value
		changed.emit()

## Defines the maximum number of nodes the spawn can invoke withouth stop the timer
@export var max_node_at_a_time := 1:
	set(value):
		
		if value < 1:
			value = 1
		
		max_node_at_a_time = value

@export var can_spawn := true:
	set(value):
		
		if value == can_spawn:
			return
		
		can_spawn = value
		changed.emit()

## null if don't use node
@export var default_node_to_spawn: PackedScene

@export var spawn_method: BaseNodeSpawnMethod
