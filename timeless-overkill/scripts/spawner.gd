extends Node

@onready var player : CharacterBody2D = $"../player"
@onready var enemy_node = $"../Enemies"
var zombie_scene = preload("res://scenes/entities/zombie.tscn")
var person1_scene = preload("res://scenes/person_1.tscn")


func _on_timer_timeout() -> void:
	generate_random_pos()
	var zombie = zombie_scene.instantiate()
	zombie.player = player
	enemy_node.add_child(zombie)
	zombie.global_position = generate_random_pos() 
	var person1 = person1_scene.instantiate()
	person1.player = player
	enemy_node.add_child(person1)
	person1.global_position = generate_random_pos()

func generate_random_pos()->Vector2:
	#temporal fix
	var xmin := -912
	var xmax := 1968
	var ymin := -865
	var ymax := 1392
	var random_pos = Vector2(randi_range(xmin,xmax),randi_range(ymin,ymax))
	while random_pos.distance_to(player.global_position) <= 600:
		random_pos = Vector2(randi_range(xmin,xmax),randi_range(ymin,ymax))
	return random_pos
