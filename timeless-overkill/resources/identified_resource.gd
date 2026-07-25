@abstract
extends ShareableResource

class_name IdentifiedResource

@export_custom(PROPERTY_HINT_TYPE_STRING, "", ExportUtils.VISIBLE_READ_ONLY)
var _id: String

## id, is equal than the registry string_id on [class Registry]
var id:
	get: return _id

@export var name: String:
	set(value):
		
		name = value
		
		if not Engine.is_editor_hint():
			return
		
		_id = name.to_lower().replace(" ", "_")

@export_multiline() var description: String
