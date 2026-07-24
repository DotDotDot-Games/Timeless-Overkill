@tool
extends CharacterBody2D

class_name BulletNode

signal on_bounce

@export var stats: BulletStats
@onready var sprite: Sprite2D = $Sprite2D

static func generate(data: BulletStats) -> BulletNode:
	
	var node: BulletNode = load(data.scene).instantiate()
	
	return node

func _ready():
	sprite.texture = stats.texture
	
	if not Engine.is_editor_hint():
		stats = stats.duplicate(true)

func _physics_process(delta: float) -> void:
	
	if Engine.is_editor_hint():
		return
	
	# Add the gravity.
	
	var collision := move_and_collide(velocity*delta)
	
	if collision:
		
		var collider := collision.get_collider()
		
		if collider.is_in_group("players") and can_damage():
			collider.damage(stats.damage)
			queue_free()
		else:
			bounce(collision.get_normal())

func bounce(collision: Vector2):
	#print("Bullet Bounced: ", stats.bounces.to_dict())
	if stats.bounces.current_value == 0:
		self.queue_free()
		return
	
	stats.bounces.current_value -= 1
	
	var vel_bounce := velocity.bounce(collision)
	rotation = vel_bounce.angle()
	velocity = vel_bounce
	
	on_bounce.emit()

func can_damage() -> bool:
	return stats.bounces.max_value - stats.bounces.current_value >= 1
