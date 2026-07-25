extends BaseRegistrySpawnMethod

class_name UpgradeSpawnMethod

func create() -> UpgradeNode:
	
	if _IDS.is_empty():
		return
	
	var node: UpgradeNode = load("res://scenes/upgrades/upgrade_node.tscn").instantiate()
	var upgrade: BaseUpgradeData = DATABASE.load_entry(_IDS.pop_front())
	
	_add_new_value(upgrade)
	node.upgrade = upgrade
	
	return node

func _on_database_setted() -> void:
	_IDS = DATABASE.filter(&"level", 1)
	_IDS.shuffle()
	print(_IDS)

func _add_new_value(loaded_upgrade: BaseUpgradeData) -> void:
	
	var new_id := loaded_upgrade.id.erase(loaded_upgrade.id.length()-1)
	new_id += str(loaded_upgrade.level+1)
	
	var new_value: Variant = DATABASE.where({
		&"level": loaded_upgrade.level+1,
		&"_id": new_id
	})
	
	if not new_value.is_empty():
		_IDS.insert(_IDS.size()-1, new_value.front())
	
	print(_IDS)
