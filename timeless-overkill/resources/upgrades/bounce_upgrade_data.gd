@tool
extends BaseStatsUpgradeData

class_name BounceUpgradeData

func _waited_type(obj: Object) -> bool:
	return obj is PlayerNode

func set_upgrade(obj: Object) -> void:
	
	var player := obj as PlayerNode
	
	player.gun.bullet.bounces = roundi(_calc_upgrade(player.gun.bullet.bounces))
