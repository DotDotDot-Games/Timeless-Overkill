@tool
@abstract
extends ItemData

class_name BaseUpgradeData

@export var level := 1

func _init() -> void:
	self.type = ItemType.Enum.UPGRADE

func _validate_property(property: Dictionary) -> void:
	
	if property.name == "type":
		property.usage |= PROPERTY_USAGE_READ_ONLY

## By default return true, that's is for custom types on childs
@warning_ignore("unused_parameter")
func _waited_type(obj: Object) -> bool:
	return true

func apply(obj: Object) -> bool:
	
	if Engine.is_editor_hint():
		return false
	
	print("Upgrade: Verifying type")
	if _waited_type(obj):
		set_upgrade(obj)
		print("Upgrade: Setted upgrade")
		return true
	
	print("Upgrade: Can't set upgrade")
	return false

@abstract
func set_upgrade(obj: Object) -> void
