@tool
extends BaseStatsUpgradeData

class_name SpeedUpgradeData

func _waited_type(obj: Object) -> bool:
	return obj is PlayerNode

func set_upgrade(obj: Object) -> void:
	
	var player := obj as PlayerNode
	
	player.speed = _calc_upgrade(player.speed)
