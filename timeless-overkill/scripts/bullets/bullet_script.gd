extends CharacterBody2D

var bullet_data : BulletType
var direction : Vector2 = Vector2(0,0)

var bounces : int
var pierce : int
var speed
var lifetime
var color : Color
var bullet_damage
var point_mult : float
var hit_mult := 1.0
@onready var timer: Timer = $Timer
var hit_particles = preload("res://scenes/gun_particles.tscn")

func _ready():
	set_up_variables()
	velocity = direction * speed
	timer.wait_time = lifetime
	timer.start()
	
	
func _physics_process(delta: float) -> void:
	modulate = color
	var collision = move_and_collide(velocity)
	if collision:
		pierce -= 1
		var collider = collision.get_collider()
		if collider.is_in_group("Enemies") or collider.is_in_group("Players"):
			if damage(collider) and collider.is_in_group("Enemies"):
				point_mult = bullet_data.points * hit_mult
				ScoreCounter.score += collider.stats.points * point_mult
				hit_mult *= 1.25
			collider.hit()
			if pierce <=0 :
				spawn_particle()
		
		if bounces >= 1:
			velocity = velocity.bounce(collision.get_normal())
			bounces -= 1
		else:
			if pierce <= 0:
				spawn_particle()
				queue_free()
func spawn_particle():
	var particles = hit_particles.instantiate()
	particles.global_position = global_position
	get_parent().add_child(particles)
	particles.modulate = bullet_data.color
	particles.emitting = true
	particles.modulate = color
	
func damage(collider):
	return collider.damage(bullet_damage)
	
func set_up_variables():
	
	bounces = bullet_data.bounces
	pierce = bullet_data.pierce
	point_mult = bullet_data.points * hit_mult
	if speed == null:
		speed = bullet_data.bullet_speed
	if bullet_damage == null:
		bullet_damage = bullet_data.damage
	if color == null:
		modulate = bullet_data.color
	if lifetime == null:
		lifetime = bullet_data.lifetime

func _on_timer_timeout() -> void:
	queue_free() # Replace with function body.
