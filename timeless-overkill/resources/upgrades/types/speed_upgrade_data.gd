@tool
extends BaseStatsUpgradeData

class_name SpeedUpgradeData

func can_apply_to(obj: Object) -> bool:
	return obj is PlayerNode

func set_upgrade(obj: Object) -> void:
	
	var player := obj as PlayerNode
	
	player.speed = _calc_upgrade(player.speed)
