@tool
extends BaseUpgradeData

class_name BulletUpgradeData

@export var new_bullet: BulletType

func _waited_type(obj: Object) -> bool:
	return obj is PlayerNode

func set_upgrade(obj: Object) -> void:
	var player := obj as PlayerNode
	
	player.gun.bullet = new_bullet
	
	if not player.gun_changed.is_connected(_on_change_gun):
		player.gun_changed.connect(_on_change_gun.bind(player))

func _on_change_gun(player: PlayerNode) -> void:
	player.gun.bullet = new_bullet
