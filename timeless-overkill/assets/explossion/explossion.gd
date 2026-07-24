extends Node2D

class_name ExplossionNode

@onready var timer: Timer = $Timer
@export var explossion_damage := 35.0

static func generate() -> ExplossionNode:
	
	var node: ExplossionNode = load("res://assets/explossion/explossion.tscn").instantiate()
	return node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()

func _on_timer_timeout() -> void:
	self.queue_free()

func _on_area_body_entered(body: Node2D) -> void:
	
	if body.has_method("damage"):
		body.damage(explossion_damage)
