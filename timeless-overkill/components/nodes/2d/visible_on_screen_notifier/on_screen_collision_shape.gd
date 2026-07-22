@tool
extends VisibleOnScreenNotifier2D

class_name OnScreenCollisionShape

@export var collision: CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	while collision.shape == null:
		await get_tree().process_frame
	
	if not collision.shape.changed.is_connected(_on_change_shape):
		collision.shape.changed.connect(_on_change_shape)
		
	_on_change_shape()

func _on_change_shape() -> void:
	
	if not collision.shape:
		return
	
	self.rect = collision.shape.get_rect()
	self.transform = collision.transform
