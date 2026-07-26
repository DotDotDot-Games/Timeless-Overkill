@tool
extends BulletNode

class_name ExpansiveBulletNode

const angles := [
	90,
	135,
	180,
	225,
	270
]

func _on_bounce() -> void:
	
	var scene := preload("res://content/bullets/mini_bullet/mini_bullet.tscn")
	var bullets_container: Node = get_tree().root.find_child("Bullets", true, false)
	
	#if not bullets_container:
		#printerr("Bullets Container: No bullets_container")
	#else:
		#print("Bullets Container: Yes Bullets!")
	
	var direction := velocity.normalized()
	#print("Expansive Bullet: original angle = ", rad_to_deg(direction.angle()))
	#print("Expansive Bullet: ", rad_to_deg(velocity.angle()))
	
	#print("Mini Bullet: Invoking new bullets")
	for angle in angles:
		var mini_bullet: BulletNode = scene.instantiate()
		
		mini_bullet.global_position = global_position
		mini_bullet.velocity = direction.rotated(deg_to_rad(angle)) * mini_bullet.stats.speed
		
		#print("Mini Bullet: Velocity = ", mini_bullet.velocity)
		#print("Mini Bullet: Angle = ", mini_bullet.velocity.angle())
		#print("Mini Bullet: Length = ", mini_bullet.velocity.length())
		bullets_container.add_child(mini_bullet)
