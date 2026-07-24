@tool
extends Node2D

class_name WeaponNode

## You can keep this empty
@export var bullets_container: Node

## Muzzle of the weapon
@onready var muzzle: Node2D = $Muzzle
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var fire_cooldown: Timer = $Timer

@export var player: Resource
@export var stats: WeaponData:
	set(value):
			
		stats = value
		
		if Engine.is_editor_hint():
			_update_stats()
			return

var can_fire := true

static func generate(data: WeaponData) -> WeaponNode:
	return load(data.scene).instantiate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	_update_stats()
	
	if Engine.is_editor_hint():
		return
		
	#print("Generated weapon: ", stats.to_dict())
	if not bullets_container:
		bullets_container = get_tree().root.find_child("Bullets", true, false)
		print("Bullets Container: getted = ", bullets_container)

func _update_stats():
	if not stats:
		return
	
	if not Engine.is_editor_hint():
		stats = stats.duplicate(true)
	
	#print(sprite)
	sprite.sprite_frames = stats.texture
	fire_cooldown.wait_time = stats.fire_rate

func use() -> void:
	
	if Engine.is_editor_hint():
		return
	
	for i in range(stats.bullets_per_shot):
		
		var bullet := BulletNode.generate(stats.bullet)
		
		var angle := _bullet_angle_spawn_method(i)
		
		_set_bullet_rotation(bullet, angle)
		_set_bullet_velocity(bullet)
		_set_bullet_spawn(bullet)
		
		if self.sprite.sprite_frames.has_animation("shooting"):
			self.sprite.play("shooting")
		
		bullets_container.add_child(bullet)
		#print("Bullet spawned!")

func _bullet_angle_spawn_method(idx: int) -> float:
	
	const spread := 30.0
	
	if stats.bullets_per_shot > 1:
		return lerp(-spread/2.0, spread/2.0, float(idx)/float(stats.bullets_per_shot-1))
	else:
		return 0.0

@warning_ignore("unused_parameter")
func _set_bullet_spawn(bullet: BulletNode, idx := 0) -> void:
	bullet.global_position = muzzle.global_position

func _set_bullet_rotation(bullet: BulletNode, angle := 0.0) -> void:
	bullet.global_rotation = muzzle.global_rotation + deg_to_rad(angle)

@warning_ignore("unused_parameter")
func _set_bullet_velocity(bullet: BulletNode, idx := 0) -> void:
	bullet.velocity = Vector2.RIGHT.rotated(bullet.global_rotation) * stats.bullet.speed

func _physics_process(_delta: float) -> void:
	
	if Engine.is_editor_hint():
		return
	
	var action := "SHOOT_P" + str(player.stats.player_type+1)
		
	if can_shoot(action):
		use()
		fire_cooldown.start()

func can_shoot(action: String) -> bool:
	
	#print("Input Shoot: can fire? ", can_fire)
	if not can_fire:
		return false
	
	#print("Input Shoot: fire_cooldown = ", fire_cooldown.time_left)
	if not fire_cooldown.is_stopped():
		return false
	
	if stats.is_automatic:
		return Input.is_action_pressed(action)
	else:
		return Input.is_action_just_pressed(action)
