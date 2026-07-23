extends AnimatedSprite2D

func _on_animation_finished() -> void:
	
	if animation == "shooting":
		self.play("default")
