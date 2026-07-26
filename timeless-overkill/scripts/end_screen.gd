extends Control


func _ready():
	LevelCountDown.time_ended.connect(on_time_ended)

func _on_main_menu_btn_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_restart_btn_pressed() -> void:
	get_tree().paused = false
	MapTracker.plr_died = true
	get_tree().change_scene_to_file("res://scenes/map_selection_menu.tscn")

func on_time_ended():
	self.show()
	get_tree().paused = true
