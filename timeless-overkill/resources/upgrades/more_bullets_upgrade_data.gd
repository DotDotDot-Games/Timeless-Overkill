@tool
extends BaseStatsUpgradeData

class_name MoreBulletsUpgradeData

func _waited_type(obj: Object) -> bool:
	return obj is PlayerNode

func set_upgrade(obj: Object) -> void:
	
	var player := obj as PlayerNode
	
	player.gun.bullet_count = int(_calc_upgrade(player.gun.bullet_count))
