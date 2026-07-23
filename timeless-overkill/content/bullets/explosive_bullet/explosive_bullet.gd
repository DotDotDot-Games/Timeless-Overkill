@tool
extends BulletNode

class_name ExplosiveBulletNode

func _on_bounce() -> void:
	print("Explosive Bullet: Explosion!")
	
	add_child(ExplossionNode.generate())
