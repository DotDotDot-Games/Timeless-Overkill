extends PropertyNode

class_name PropertyTextureNode

func _verify_self_type() -> bool:
	return (self as Object) is TextureRect

func _set_texture(value: Texture2D) -> void:
	self.texture = value

func _set_modulate(value: Timer) -> void:
	pass
