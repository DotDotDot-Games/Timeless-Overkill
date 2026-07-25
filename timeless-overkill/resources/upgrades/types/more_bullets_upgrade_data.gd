@tool
extends BaseStatsUpgradeData

class_name MoreBulletsUpgradeData

func can_apply_to(obj: Object) -> bool:
	return obj is PlayerNode

func set_upgrade(obj: Object) -> void:
	
	var player := obj as PlayerNode
	
	player.gun.bullet_count = roundi(_calc_upgrade(player.gun.bullet_count))
