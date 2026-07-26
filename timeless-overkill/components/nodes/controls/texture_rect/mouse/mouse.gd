@tool
extends TextureRect

class_name MouseButtonNode

## 0 to idle
@export var button: MouseButton:
	set(value):
		
		button = value
		update_texture()

@export var mouse_textures := MouseButtonsTextures.new()

func _ready():
	update_texture()

func update_texture() -> void:
	
	if not mouse_textures:
		return
	
	if button == 0:
		self.texture = mouse_textures.idle
		return
	
	var event := InputEventMouseButton.new()
	event.button_index = button
	
	var to_get = event.as_text().to_lower().replace("mouse", "").replace("button", "").strip_edges()
	#print(to_get)
	self.texture = mouse_textures.get(to_get)
	
	if texture:
		self.custom_minimum_size = self.texture.get_size()
		self.update_minimum_size()
