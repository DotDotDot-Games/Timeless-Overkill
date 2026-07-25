@tool
extends AnimatedSprite2D

class_name ItemSpawnerNode

@onready var timer: Timer = $Timer
@onready var generated_items: Node = $GeneratedItems

## Spawner info
@export var info: ItemSpawnerData:
	set(value):
		
		info = value
		
		if Engine.is_editor_hint():
			_update_info()

## Item spawned by spawner (null if is not spawned)
@export var item: WorldItemData = null

## Define if spawner is spawning a new item
var spawning := true

@export_file("*.tres") var DATABASE_PATH: String:
	set(value):
		DATABASE_PATH = value
		
		if value:
			DATABASE = load(DATABASE_PATH)
		else:
			DATABASE = null

@export_custom(PROPERTY_HINT_RESOURCE_TYPE, "", ExportUtils.VISIBLE_READ_ONLY)
var DATABASE: Registry

## Cache for ID's to use
var IDS: Array[StringName] = []

func _ready():
	if Engine.is_editor_hint():
		return
	
	_update_info()
	_start_spawn()

func _process(_delta):
	
	if Engine.is_editor_hint():
		return
	
	if self.sprite_frames.has_animation(&"spawning"):
		if spawning and timer.time_left <= 2.5 and animation != &"spawning":
			self.play("spawning")
		else:
			if not spawning and animation == &"spawning":
				self.play("default")

func _update_info():
	
	if not info:
		return
	
	if not Engine.is_editor_hint():
		print(info.to_dict())
	
	DATABASE = load(DATABASE_PATH)
	_update_ids()
	self.sprite_frames = info.texture

func _update_ids() -> void:
	
	IDS = DATABASE.filter(&"item_data", Callable(self, "_can_spawn_item"))
	print("IDs: ", IDS)

func _can_spawn_item(data: ItemData) -> bool:
	
	if info.only.size() > 0:
		return data.id in info.only and data.spawneable
	
	if info.only_types.size() > 0:
		
		if not data.type in info.only_types:
			return false
	
	if info.only_categories.size() > 0:
		
		for category: ItemCategory.Enum in data.categories:
			var in_cat := category in info.only_categories
			
			if not in_cat:
				return false
	
	if info.ignore_types.size() > 0:
		
		if data.type in info.ignore_types:
			return false
	
	if info.ignore_categories.size() > 0:
		
		for category: ItemCategory.Enum in data.categories:
			var not_in_cat := category not in info.ignore_categories
			
			if not not_in_cat:
				return false
	
	return (not data.id in info.ignore) and data.spawneable

func _start_spawn() -> void:
	spawning = true
	timer.start(info.spawn_time)

func _start_despawn() -> void:
	spawning = false
	
	if info.despawn_time >= 0:
		timer.start(info.despawn_time)

func _on_timer_timeout() -> void:
	
	if spawning:
		_start_despawn()
		
		item = DATABASE.load_entry(IDS.pick_random())
		
		var node: ItemPickableNode = load(item.pickable_scene).instantiate()
		node.global_position = self.global_position
		
		generated_items.add_child(node)
		print("Spawned: ", item.to_dict())
	else:
		_remove_generated_item()
		_start_spawn()

func _remove_generated_item() -> void:
	item = null
	
	for child in generated_items.get_children():
		
		if child is ItemPickableNode:
			child.queue_free()
