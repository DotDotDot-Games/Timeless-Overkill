@tool
extends ItemData
class_name GunType

signal bullet_changed

@export var spread_angle : float
@export var bullet_count : int
@export var reload_time : float
@export var fire_rate : float
@export var bullet : BulletType:
	set(value):
		
		if bullet == value:
			return
		
		bullet = value
		
		if not Engine.is_editor_hint():
			bullet_changed.emit()
		
@export var scene : PackedScene
