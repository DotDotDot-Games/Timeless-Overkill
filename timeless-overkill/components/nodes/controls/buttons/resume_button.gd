extends Button

class_name ResumeButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if not self.pressed.is_connected(_on_pressed):
		self.pressed.connect(_on_pressed)

func _on_pressed() -> void:
	owner.resume()
