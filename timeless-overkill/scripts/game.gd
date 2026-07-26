extends Node2D

@onready var kill_screen = $CanvasLayer/kill_screen

func _ready() -> void:
	ScoreCounter.reset_score()

func _on_player_kill_screen_show() -> void:
	kill_screen.show()
