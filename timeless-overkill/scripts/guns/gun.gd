extends Node2D

@onready var fire_hole = $fire_hole
var gun_data: GunType


func shoot(direction,bullet_node):
	var angle = deg_to_rad(gun_data.spread_angle)
	for i in gun_data.bullet_count:
		var bullet_dir = direction.rotated(randf_range(-angle,angle))
		fire(bullet_dir,bullet_node)

func fire(direction : Vector2, bullet_node : Node) -> void:
	var bullet = gun_data.bullet.scene.instantiate()
	bullet.direction = direction
	bullet.bullet_data = gun_data.bullet
	bullet_node.add_child(bullet)
	bullet.global_position = fire_hole.global_position
	

	
