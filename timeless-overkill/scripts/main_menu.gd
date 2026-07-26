extends Control

@onready var my_btn = $buttons/Button
	
func _on_button_pressed() -> void:
	MapTracker.plr_died = true
	get_tree().change_scene_to_file("res://scenes/map_selection_menu.tscn")
