extends CharacterBody2D

var bullet_data : BulletType
var direction : Vector2 = Vector2(0,0)

var bounces : int
var pierce : int
@onready var timer: Timer = $Timer

func _ready():
	velocity = direction * bullet_data.bullet_speed
	set_up_variables()
	timer.wait_time = bullet_data.lifetime
	timer.start()
	
func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity)
	if not collision:
		return
	if bounces >= 1:
		velocity = velocity.bounce(collision.get_normal())
		bounces -= 1
	else:
		queue_free()
		
func set_up_variables():
	bounces = bullet_data.bounces
	pierce = bullet_data.pierce


func _on_timer_timeout() -> void:
	queue_free() # Replace with function body.
