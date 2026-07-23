@tool
extends BulletNode

class_name RicochetingBulletNode

@export var multiplicator := 1.2

func _on_bounce() -> void:
	print("Ricochet Bullet: Before speed = ", velocity)
	velocity *= multiplicator
	print("Ricochet Bullet: More Speed = ", velocity)
