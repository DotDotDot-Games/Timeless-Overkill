extends Node

@onready var player : CharacterBody2D = $"../player"
var zombie_scene = preload("res://scenes/entities/zombie.tscn")
@onready var enemy_node = $"../Enemies"
var zombie_stats = preload("res://content/entities/zombie.tres")




func _on_timer_timeout() -> void:
	var xmin := -912
	var xmax := 1968
	var ymin := -865
	var ymax := 1392
	var random_pos = Vector2(randi_range(xmin,xmax),randi_range(ymin,ymax))
	while random_pos.distance_to(player.global_position) <= 600:
		random_pos = Vector2(randi_range(xmin,xmax),randi_range(ymin,ymax))
	var zombie = zombie_scene.instantiate()
	zombie.stats = zombie_stats
	zombie.player = player
	enemy_node.add_child(zombie)
	zombie.global_position = random_pos
	
