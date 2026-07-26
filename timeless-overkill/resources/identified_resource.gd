
@tool
extends ShareableResource

class_name IdentifiedResource

@export var set_custom_id := false

@export var _id: String

## id, is equal than the registry string_id on [class Registry]
var id: String:
	get: return _id

@export var name: String:
	set(value):
		
		name = value
		
		if not Engine.is_editor_hint():
			return
		
		if not set_custom_id:
			_id = name.to_snake_case()

@export_multiline() var description: String

func _validate_property(property: Dictionary) -> void:
	
	if property.name == "_id":
		
		if not set_custom_id:
			property.usage |= PROPERTY_USAGE_READ_ONLY
