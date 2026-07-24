extends ShareableResource

class_name WorldItemData

@export var _id: String

var id:
	get: return _id

## Icon of item in UI
@export var icon: Texture2D

## Data of item to use in UI
@export var item_data: ItemData

@export_file("*.tscn") var pickable_scene: String
