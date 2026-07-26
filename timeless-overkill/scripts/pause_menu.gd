extends Control

var is_pausing : bool = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("PAUSE"):
		if !is_pausing:
			is_pausing = true
			self.show()
			get_tree().paused = true
		else:
			self.hide()
			get_tree().paused = false
			is_pausing = false



func _on_resume_btn_pressed() -> void:
	is_pausing = false
	self.hide()
	get_tree().paused = false


func _on_back_btn_pressed() -> void:
	is_pausing = false
	get_tree().paused = false
	self.hide()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
