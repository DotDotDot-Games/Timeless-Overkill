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
		_on_set_database()

func _on_set_database() -> void:
	pass
