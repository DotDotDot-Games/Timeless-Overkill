@tool
extends CanvasItem

class_name ToggleCanvasItemVisibility

@export var visible_in_game := true

func _ready() -> void:
	
	if not Engine.is_editor_hint():
		self.visible = visible_in_game
