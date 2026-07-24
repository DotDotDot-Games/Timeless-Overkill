extends CharacterBody2D

@export var player : Node2D
@onready var nav_agent : NavigationAgent2D = $NavigationAgent2D
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@export var stats: EnemyStats
@onready var damage_timer : Timer = $DamageTimer
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var particle_node : Node = $"../../Particles"
@export var gun : GunType
@onready var gun_spawn : Node2D = $GunSpawn
@onready var bullets_node : Node = get_parent().get_node("EnemyBullets")
@onready var shoot_timer : Timer = $ShootTimer
var gun_scene 
var can_fire := true

var person1_stats = preload("res://content/entities/person1.tres")
var death_particles = preload("res://scenes/death_particles.tscn")
var health_bar = preload("res://scenes/healthbar.tscn")

var health : float
var max_health : float
var color : Color

var can_damage = true
func _ready():
	stats = person1_stats
	gun = person1_stats.weapon
	add_to_group("Enemies")
	set_up_variables()
	var health_bar_a = health_bar.instantiate()
	add_child(health_bar_a)
	if gun != null:
		gun_scene = gun.scene.instantiate()
		add_child(gun_scene)
		gun_scene.global_position = gun_spawn.global_position
		gun_scene.gun_data = gun
		shoot_timer.wait_time = gun.fire_rate * 2
	
func set_up_variables():
	health = stats.health
	max_health = stats.health
	color = stats.color
	
func _physics_process(_delta: float) -> void:
	if health <= 0:
		kill()
	
		
	var dir = global_position.direction_to(nav_agent.get_next_path_position()).normalized()
	velocity = dir * stats.speed
	self.rotation = dir.angle()
	if global_position.distance_to(player.global_position) <= stats.range:
		move_and_slide()
		if gun != null:
			shoot(dir)
		
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider.is_in_group("Players"):
			deal_damage(collider)
	
func shoot(angle):
	if can_fire:
		gun_scene.enemy_shoot(angle,bullets_node)
		can_fire = false
		
func deal_damage(collider):
	if can_damage:
		if collider.damage(stats.damage):
			damage_timer.start()
			can_damage = false
			collider.hit()
			
func damage(value):
	health -= value
	
func hit():
	
	animation_player.play("hit_flash")
func kill():
	var particles = death_particles.instantiate()
	particles.global_position = global_position
	particle_node.add_child(particles)
	particles.modulate = color
	particles.emitting = true
	queue_free()
	
func make_path():
	nav_agent.target_position = player.global_position


func _on_shoot_timer_timeout() -> void:
	shoot_timer.start()
	can_fire = true


func _on_nav_timer_timeout() -> void:
	make_path()


func _on_damage_timer_timeout() -> void:
	can_damage = true
