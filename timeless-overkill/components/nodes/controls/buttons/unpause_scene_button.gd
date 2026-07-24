extends SceneButton

class_name UnpauseSceneButton

func _on_pressed() -> void:
	get_tree().paused = false
	super._on_pressed()
