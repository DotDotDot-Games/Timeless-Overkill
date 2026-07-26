extends Control

@onready var map_lbl = $selection_wheel/map_bg_lbl
@onready var map_img = $selection_wheel/map_bg_margin/map_bg
@onready var my_progress_bar = $TextureProgressBar
var is_loading_game : bool = false

var maps_selection : Dictionary = {
	1:
		{"name": "MAP 1",
		"image": "res://assets/map_backgrounds/map_1_bg.png",
		"path": "res://scenes/game.tscn"},
	2:
		{"name": "MAP 2",
		"image": "res://assets/map_backgrounds/map_2_bg.png",
		"path": "res://scenes/map_selection_menu.tscn"},
}

var num_of_maps : int = maps_selection.size()
var map_selected : int = 1

func display_map(map : int):
	map_lbl.text = maps_selection[map]["name"]
	map_img.texture = load(maps_selection[map]["image"])
	map_selected = map
	
	
func _ready():
	display_map(1)
	
func map_index(map_num : int) -> int:
	if map_num == 0:
		return num_of_maps
	
	if map_num > num_of_maps:
		return 1
	
	return map_num
	
func _on_previous_map_pressed() -> void:
	display_map(map_index(map_selected - 1))


func _on_next_map_pressed() -> void:
	display_map(map_index(map_selected + 1))


func _on_go_back_pressed() -> void:
	map_selected = 1
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_play_map_pressed() -> void:
	loading_game()
	is_loading_game = true


var GAME_SCENE = maps_selection[map_selected]["path"]

func loading_game():
	$button.hide()
	$selection_wheel.hide()
	my_progress_bar.show()
	$clock_aguja.show()
	$loading_lbl.show()
	ResourceLoader.load_threaded_request(GAME_SCENE)

func _process(_delta):
	if is_loading_game:
		var progress = []
		var status = ResourceLoader.load_threaded_get_status(GAME_SCENE, progress)

		if progress.size() > 0:
			var value = progress[0] * 100
			my_progress_bar.value = value
			$clock_aguja.rotation_degrees = value * 3.6

		if status == ResourceLoader.THREAD_LOAD_LOADED:
			var packed_scene = ResourceLoader.load_threaded_get(GAME_SCENE)
			get_tree().change_scene_to_packed(packed_scene)
