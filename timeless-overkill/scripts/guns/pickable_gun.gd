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
	
	if not sprite:
		return
	
	sprite.sprite_frames = data.texture

func _ready() -> void:
	_on_set_gun()

func _on_player_body_entered(body: Node2D) -> void:
	
	var player := body as PlayerNode
	
	if not player:
		return
	
	player.set_weapon(data)
	queue_free()
