@tool
@abstract
extends IdentifiedResource

class_name ItemData

## Texture of item in hand
@export var texture: SpriteFrames

## Define if the item can spawn in spawners
@export var spawneable := true

## Define the type of the item (for the spawners)
@export var type: ItemType.Enum
@export var categories: Array[ItemCategory.Enum] = []
