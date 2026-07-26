extends Node2D

class_name PickableGun

@onready var sprite: AnimatedSprite2D = $Sprite

@export var data: GunType:
	set(value):
		
		if data == value:
			return
		
		data = value
		_on_set_gun()
		
func _on_set_gun() -> void:
	
	if not data:
		sprite.sprite_frames = null
		return
	
	sprite.sprite_frames = data.texture
	
