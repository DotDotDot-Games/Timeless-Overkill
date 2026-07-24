@tool
extends BaseStatsUpgradeData

class_name DamageUpgradeData

func _waited_type(obj: Object) -> bool:
	return obj is PlayerNode

func set_upgrade(obj: Object) -> void:
	
	var player := obj as PlayerNode
	
	player.gun.bullet.damage = _calc_upgrade(player.gun.bullet.damage)
	print("Damage Upgrade: Aumented Damage")
