@tool
@abstract
extends BaseUpgradeData

class_name BaseStatsUpgradeData

@export var extra_value: float
@export var extra_multiplier := 1.0

func _calc_upgrade(value: float) -> float:
	return extra_value + (value * extra_multiplier)
