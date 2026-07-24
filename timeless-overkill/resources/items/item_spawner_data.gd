extends ShareableResource

class_name ItemSpawnerData

@export var texture: SpriteFrames

## -1 by default to spawn indefinitely times
@export var spawn_times := -1

## Item spawn time
@export var spawn_time := 5.0

## Item despawn time (Leave at -1.0 if you don't want them to despawn)
@export var despawn_time := -1.0

## WorldItems that the spawner ONLY spawns
@export var only: Array[StringName] = []

@export var only_types: Array[ItemType.Enum] = []

@export var only_categories: Array[ItemCategory.Enum] = []

## WorldItems that the spawner will not spawn
@export var ignore: Array[StringName] = []

@export var ignore_types: Array[ItemType.Enum] = []

@export var ignore_categories: Array[ItemCategory.Enum] = []
