extends Node

@onready var player : CharacterBody2D = $"../player"
@onready var enemy_node = $"../Enemies"
var zombie_scene = preload("res://scenes/entities/zombie.tscn")
var person1_scene = preload("res://scenes/person_1.tscn")


func _on_timer_timeout() -> void:
	var random_number := randi_range(1,3)
	if random_number == 1:
		spawn_scene(zombie_scene)
		spawn_scene(zombie_scene)
		spawn_scene(zombie_scene)
	elif random_number == 2:
		spawn_scene(person1_scene)
		spawn_scene(zombie_scene)
	elif random_number == 3:
		spawn_scene(person1_scene)
		spawn_scene(person1_scene)
func spawn_scene(scene):
	var instance = scene.instantiate()
	instance.player = player
	enemy_node.add_child(instance)
	instance.global_position = generate_random_pos() 
func generate_random_pos()->Vector2:
	#temporal fix
	var xmin := -912
	var xmax := 1968
	var ymin := -865
	var ymax := 1392
	var random_pos = Vector2(randi_range(xmin,xmax),randi_range(ymin,ymax))
	while 300 <=random_pos.distance_to(player.global_position) and random_pos.distance_to(player.global_position) <= 800:
		random_pos = Vector2(randi_range(xmin,xmax),randi_range(ymin,ymax))
	return random_pos
