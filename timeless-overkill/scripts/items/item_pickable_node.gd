@tool
extends Sprite2D

class_name ItemPickableNode

## Execute when the item is picked up
signal on_picked(node_who_picked: Node)

@export var info: ItemPickableData

## Define the time you need to stay still to grab the item
@export var time_to_pickup := 1.0

## Store the player IDs within the timers and track the time they remain stationary.
var timers: Dictionary[Node, float] = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if not Engine.is_editor_hint():
		return
	
	if info:
		self.texture = info.texture

# TODO: Implement pickup when the player is implemented.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Engine.is_editor_hint():
		return
	
	for player in timers:
		
		if player.moving:
			timers[player] = time_to_pickup
		else:
			timers[player] -= delta
		
		if timers[player] <= 0:
			pick(player)
			break

func _on_body_entered(body: Node2D) -> void:
	
	if Engine.is_editor_hint():
		return
	
	timers[body] = time_to_pickup

func _on_body_exited(body: Node2D) -> void:
	
	if Engine.is_editor_hint():
		return
	
	timers.erase(body)

func pick(body: Node) -> void:
	on_picked.emit(body)
	queue_free()
