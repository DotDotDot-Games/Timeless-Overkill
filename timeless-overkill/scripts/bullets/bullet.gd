extends CharacterBody2D

var bullet_data : BulletType
var direction : Vector2 = Vector2(0,0)

var bounces : int
var pierce : int
@onready var timer: Timer = $Timer
var hit_particles = preload("res://scenes/gun_particles.tscn")

func _ready():
	velocity = direction * bullet_data.bullet_speed
	set_up_variables()
	timer.wait_time = bullet_data.lifetime
	timer.start()
	
func _physics_process(delta: float) -> void:
	
	var collision = move_and_collide(velocity)
	if collision:
		var collider = collision.get_collider()
		if collider.is_in_group("Enemies"):
			damage(collider)
			collider.hit()
			spawn_particle()
		if bounces >= 1:
			velocity = velocity.bounce(collision.get_normal())
			bounces -= 1
		else:
			spawn_particle()
			queue_free()
func spawn_particle():
	var particles = hit_particles.instantiate()
	particles.global_position = global_position
	get_parent().add_child(particles)
	particles.modulate = bullet_data.color
	particles.emitting = true
	
func damage(collider):
	collider.health -= bullet_data.damage
	#
func set_up_variables():
	bounces = bullet_data.bounces
	pierce = bullet_data.pierce


func _on_timer_timeout() -> void:
	queue_free() # Replace with function body.
