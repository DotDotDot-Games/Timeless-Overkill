extends Control


func _on_back_btn_pressed() -> void:
	get_tree().paused = false
	MapTracker.plr_died = true
	get_tree().change_scene_to_file("res://scenes/map_selection_menu.tscn")


func _on_main_menu_btn_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
