extends Sprite2D

var sprite
#get from player

func _ready():
	var anim = sprite.sprite_frames.get_animation_names()[0]
	var texture = sprite.sprite_frames.get_frame_texture(anim, 0)
	self.texture = texture
	self.modulate = Color(0.6, 1.0, 1.0, 1.0)
	await ghost()

func ghost():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"modulate:a",0,0.75)
	tween.parallel().tween_property(self,"scale",Vector2.ZERO,2)
	await tween.finished
	queue_free()
