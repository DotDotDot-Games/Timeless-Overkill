@tool
extends BaseStatsUpgradeData

class_name DashDamageUpgradeData

func _waited_type(obj: Object) -> bool:
	return obj is PlayerNode

func set_upgrade(obj: Object) -> void:
	var player := obj as PlayerNode
	
	player.melee_damage = roundi(_calc_upgrade(player.melee_damage))
