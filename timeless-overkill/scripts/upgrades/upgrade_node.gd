@tool
extends Node2D

class_name UpgradeNode

@onready var sprite: AnimatedSprite2D = $Sprite
@export var upgrade: BaseUpgradeData

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if upgrade:
		sprite.sprite_frames = upgrade.texture

## Connected to an area 2d called UpgradePickbox in a scene
func _on_player_entered(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	
	if Engine.is_editor_hint():
		return
	
	var result := upgrade.apply(body)
	
	if result:
		queue_free()
