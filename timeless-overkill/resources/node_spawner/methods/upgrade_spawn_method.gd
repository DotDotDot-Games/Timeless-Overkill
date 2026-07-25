extends BaseRegistrySpawnMethod

class_name UpgradeSpawnMethod

func create() -> UpgradeNode:
	
	if _IDS.is_empty():
		return
	
	var node: UpgradeNode = load("res://scenes/upgrades/upgrade_node.tscn").instantiate()
	var upgrade: BaseUpgradeData = DATABASE.load_entry(_IDS.pop_front())
	
	_add_new_id(upgrade.next_level_id)
	node.upgrade = upgrade
	
	return node

func _on_database_setted() -> void:
	_IDS = DATABASE.filter(&"level", 1)
	_IDS.shuffle()
	print(_IDS)

func _add_new_id(id: StringName) -> void:
	
	if id:
		_IDS.insert(_IDS.size()-1, id)
	
	print(_IDS)
