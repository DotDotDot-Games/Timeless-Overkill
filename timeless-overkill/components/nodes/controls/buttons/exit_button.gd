extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if not pressed.is_connected(_on_pressed):
		pressed.connect(_on_pressed)

func _on_pressed() -> void:
	get_tree().quit()
