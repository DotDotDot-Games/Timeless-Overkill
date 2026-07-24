@tool
extends BaseStatsUpgradeData

class_name FireRateUpgradeData

func _waited_type(obj: Object) -> bool:
	return obj is PlayerNode

func set_upgrade(obj: Object) -> void:
	var player := obj as PlayerNode
	
	player.bullet_timer.wait_time = _calc_upgrade(player.gun.fire_rate)
