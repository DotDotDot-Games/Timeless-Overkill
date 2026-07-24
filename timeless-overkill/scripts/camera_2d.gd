extends Camera2D
@onready var player : CharacterBody2D = $"../player"
func _process(delta):
	global_position = lerp(player.global_position,get_global_mouse_position(),0.05)
