extends BaseRegistrySpawnMethod

class_name RandomRegistrySpawnMethod

var _IDS: Array[StringName] = []
var IDS: Array[StringName]:
	get: return _IDS

func create() -> Node2D:
	
	var node: UpgradeNode = load("res://scenes/upgrades/upgrade_node.tscn").instantiate()
	node.upgrade = DATABASE.load_entry(IDS.pick_random())
	
	return node

func _on_set_database() -> void:
	_IDS = DATABASE.get_all_string_ids()
