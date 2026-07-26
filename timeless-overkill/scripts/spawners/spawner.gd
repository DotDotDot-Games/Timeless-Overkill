extends Node

@onready var player : CharacterBody2D = $"../player"
@onready var enemy_node = $"../Enemies"
var zombie_scene = preload("res://scenes/entities/zombie.tscn")
var person_scene = preload("res://scenes/person.tscn")
@onready var spawn_timer : Timer = $Timer
func _ready():
	spawn()
	spawn()
func _on_timer_timeout() -> void:
	spawn()

func _process(_delta):
	var x = LevelCountDown.time_left 
	var a = -0.00012
	var h = 150
	var k = 7
	spawn_timer.wait_time = a * (x-h) * (x-h) + k
	
func spawn():
	var random_number := randi_range(1,3)
	if random_number == 1:
		spawn_scene(zombie_scene)
		spawn_scene(zombie_scene)
		spawn_scene(zombie_scene)
	elif random_number == 2:
		spawn_scene(person_scene)
		spawn_scene(zombie_scene)
	elif random_number == 3:
		spawn_scene(person_scene)
		spawn_scene(person_scene)

func spawn_scene(scene):
	var instance = scene.instantiate()
	instance.player = player
	enemy_node.add_child(instance)
	instance.global_position = generate_random_pos() 
	
func generate_random_pos()->Vector2:
	#temporal fix
	var xmin := -3120
	var xmax := 3120
	var ymin := -4544
	var ymax := 4544
	var random_pos = Vector2(randi_range(xmin,xmax),randi_range(ymin,ymax))
	while 400 > random_pos.distance_to(player.global_position) or 800 < random_pos.distance_to(player.global_position) :
		random_pos = Vector2(randi_range(xmin,xmax),randi_range(ymin,ymax))
	return random_pos
