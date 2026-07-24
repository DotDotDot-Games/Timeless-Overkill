extends CharacterBody2D

class_name PlayerNode

@export var gun : GunType

#facing
var can_move := true
var moving := false
var facing := Vector2(1,0)
var direction : Vector2
var saved_direction : Vector2

#scenes
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var gun_spawn : Node2D = $GunSpawn
@onready var bullets_node : Node = $"../Bullets"
@onready var health_bar : ProgressBar = $"../CanvasLayer/UI/HealthBarPlayer"
@onready var bullet_timer : Timer = $BulletCooldown
@onready var dash_timer : Timer = $DashTime
@onready var clone_node : Node = $"../Clones"
var clone_scene = preload("res://scenes/clone.tscn")
#stats
var health := 1000
var max_health := health
var speed := 300
var dash_speed := 1000
var melee_damage := 0
#gun
var gun_scene
var can_fire := true
#dash
var can_dash := true
var dashing := false
var dash_cooldown := 1.0
var dash_time = 0.15
var invincible = false

func _ready():
	gun_scene = gun.scene.instantiate()
	add_child(gun_scene)
	gun_scene.global_position = gun_spawn.global_position
	gun_scene.gun_data = gun
	health_bar.max_value = max_health
	bullet_timer.wait_time = gun.fire_rate
	bullet_timer.start()
	dash_timer.wait_time = dash_time
	add_to_group("Players")




func _physics_process(_delta: float) -> void:
	#setting up variables
	#camera.global_position = global_position
	health_bar.value = health
	
	if health <= 0:
		kill()
	
	#facing direction
	direction =   Input.get_vector("LEFT", "RIGHT", "UP", "DOWN")
	if direction != Vector2.ZERO:
		facing = direction.normalized()
		moving = true
	else:
		moving = false
	
	if moving:
		velocity = direction.normalized() * speed
	else:
		velocity = Vector2.ZERO
	var mouse_pos = get_global_mouse_position()
	var to_mouse = (mouse_pos-global_position).normalized()
	self.rotation = to_mouse.angle()
	
	#shooting

	if Input.is_action_pressed("SHOOT"):
		shoot(to_mouse)
		

	if Input.is_action_just_pressed("DASH"):
		dash()
		
	if dashing:
		invincible = true
		velocity = saved_direction.normalized() * dash_speed
		var clone = clone_scene.instantiate()
		clone.global_position = global_position
		clone.sprite = sprite
		clone.rotation = to_mouse.angle()
		clone_node.add_child(clone)
		
	move_and_slide()
	


func shoot(angle):
	if can_fire:
		gun_scene.shoot(angle,bullets_node)
		can_fire = false

func dash():
	if can_dash:
		invincible = true
		can_dash = false
		dashing = true
		saved_direction = facing
		velocity = facing.normalized() * dash_speed
		dash_timer.start()
		
func deal_damage(collider):
	if collider.damage(melee_damage):
		collider.hit()
			
func damage(value) -> bool:
	if invincible:
		return false
	health -= value
	return true
	
func take_damage(value):
	health -= value
	
func kill():
	get_tree().quit()
	queue_free()
func hit():
	animation_player.play("hit_flash")
func _on_bullet_cooldown_timeout() -> void:
	bullet_timer.start()
	can_fire = true


func _on_dash_cooldown_timeout() -> void:
	dashing = false
	var invincible_time = 0.2
	await get_tree().create_timer(invincible_time).timeout
	
	invincible = false
	await get_tree().create_timer(dash_cooldown-invincible_time).timeout
	#await get_tree().create_timer(dash_cooldown).timeout
	can_dash = true
