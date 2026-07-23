extends CharacterBody2D

@export var player : Node2D
@onready var nav_agent : NavigationAgent2D = $NavigationAgent2D
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@export var stats: EnemyStats
@onready var damage_timer : Timer = $DamageTimer
@onready var animation_player : AnimationPlayer = $AnimationPlayer
var health_bar = preload("res://scenes/healthbar.tscn")

var health : float
var max_health : float


var can_damage = true
func _ready():
	add_to_group("Enemies")
	set_up_variables()
	var health_bar_a = health_bar.instantiate()
	add_child(health_bar_a)
	
func set_up_variables():
	health = stats.health
	max_health = stats.health
	
func _physics_process(delta: float) -> void:
	if health <= 0:
		kill()
	var dir = global_position.direction_to(nav_agent.get_next_path_position()).normalized()
	velocity = dir * stats.speed
	animated_sprite.rotation = dir.angle()
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider.is_in_group("Players"):
			damage(collider)
			
		
func damage(collider):
	if can_damage:
		collider.health -= stats.damage
		damage_timer.start()
		can_damage = false
func hit():
	animation_player.play("hit_flash")
func kill():
	queue_free()
func make_path():
	nav_agent.target_position = player.global_position
	
func _on_timer_timeout() -> void:
	make_path()


func _on_damage_timer_timeout() -> void:
	can_damage = true
