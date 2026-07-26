extends Label

func _process(_delta: float) -> void:
	text = "frames" + str(Engine.get_frames_per_second())
