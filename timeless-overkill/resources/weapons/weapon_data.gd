@tool
extends ItemData

class_name WeaponData

## bullets fired per second
@export var fire_rate: float

## Determine whether the weapon can fire while the fire button is held down.
@export var is_automatic := true

## bullet fired by the weapon
@export var bullet: BulletStats

## Number of bullets the weapon fires per shot
@export var bullets_per_shot := 1

@export_file("*.tscn") var scene: String

func _init():
	self.type = ItemType.Enum.WEAPON

func _validate_property(property: Dictionary) -> void:
	
	if property.name == "type":
		property.usage |= PROPERTY_USAGE_READ_ONLY
