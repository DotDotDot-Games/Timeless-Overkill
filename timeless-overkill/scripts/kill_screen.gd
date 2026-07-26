extends Control


func _on_back_btn_pressed() -> void:
	get_tree().change_scene_to_file(MapTracker.map_selected)


func _on_main_menu_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
