@tool
extends TextureRect

class_name AnimatedTextureRect

enum SpriteSheetType {
	ROW,
	COLUMN,
	GRID
}

var start_size: Vector2
@onready var atlas := texture as AtlasTexture

@export var spritesheet_type: SpriteSheetType:
	set(value):
		spritesheet_type = value
		notify_property_list_changed()

@export var COLUMNS: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	start_size = atlas.region.size
	#print(atlas.region)

func total_frames() -> int:
	
	if spritesheet_type == SpriteSheetType.ROW:
		return total_frames_row()
	
	if spritesheet_type == SpriteSheetType.COLUMN:
		return total_frames_column()
	
	return total_frames_grid()

func total_frames_row() -> int:
	return int(atlas.atlas.get_size().x / start_size.x)

func total_frames_column() -> int:
	return int(atlas.atlas.get_size().y / start_size.y)

func total_frames_grid() -> int:
	return total_frames_row() * total_frames_column()

func set_frame(frame: int) -> void:
	
	if spritesheet_type == SpriteSheetType.ROW:
		set_frame_row(frame)
	elif spritesheet_type == SpriteSheetType.COLUMN:
		set_frame_column(frame)
	else:
		set_frame_grid(frame)

func set_frame_row(frame: int) -> void:
	atlas.region.position = Vector2(
		frame * start_size.x,
		atlas.region.position.y
	)

func set_frame_column(frame: int) -> void:
	atlas.region.position = Vector2(
		atlas.region.position.x,
		frame * start_size.y
	)

func set_frame_grid(frame: int) -> void:
	atlas.region.position = Vector2(
		(frame % COLUMNS) * start_size.x,
		(float(frame) / float(COLUMNS)) * start_size.y
	)

func _validate_property(property: Dictionary) -> void:
	
	if property.name == "COLUMNS":
		property.usage = PROPERTY_USAGE_DEFAULT
		
		if spritesheet_type != SpriteSheetType.GRID:
			property.usage = PROPERTY_USAGE_NO_EDITOR
