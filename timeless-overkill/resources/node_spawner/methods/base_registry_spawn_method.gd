@abstract
extends BaseNodeSpawnMethod

class_name BaseRegistrySpawnMethod

@export var DATABASE: Registry:
	set(value):
		
		if not value:
			return
		
		if DATABASE == value:
			return
		
		DATABASE = value
		_on_database_setted()

var _IDS: Array[StringName] = []
var IDS: Array[StringName]:
	get: return _IDS

func _on_database_setted() -> void:
	_IDS = DATABASE.get_all_string_ids()
