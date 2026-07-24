@tool
extends BaseStatsUpgradeData

class_name DashCooldownUpgradeData

func can_apply_to(obj: Object) -> bool:
	return obj is PlayerNode

func set_upgrade(obj: Object) -> void:
	var player := obj as PlayerNode
	
	player.dash_cooldown = _calc_upgrade(player.dash_cooldown)
