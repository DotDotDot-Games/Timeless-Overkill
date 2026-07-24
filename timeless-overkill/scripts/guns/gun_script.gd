extends Node2D

@onready var fire_hole = $fire_hole
var gun_data: GunType

var enemy_bullet_speed = 0.25
var enemy_bullet_damage = 1
var enemy_bullet_scale = 1.3

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
	bullet.color = bullet.bullet_data.color
	bullet.global_position = fire_hole.global_position
	
func enemy_shoot(direction,bullet_node):
	var angle = deg_to_rad(gun_data.spread_angle)
	for i in gun_data.bullet_count:
		var bullet_dir = direction.rotated(randf_range(-angle,angle))
		enemy_fire(bullet_dir,bullet_node)

func enemy_fire(direction : Vector2, bullet_node : Node) -> void:
	var bullet = gun_data.bullet.scene.instantiate()
	bullet.direction = direction
	bullet.set_collision_layer_value(2, false) 
	bullet.set_collision_layer_value(5, true) 
	bullet.set_collision_mask_value(1, true)
	bullet.set_collision_mask_value(4, false)
	bullet.bullet_data = gun_data.bullet
	bullet.scale *= enemy_bullet_scale
	bullet.speed = bullet.bullet_data.bullet_speed * enemy_bullet_speed
	bullet.bullet_damage = bullet.bullet_data.damage * enemy_bullet_damage
	bullet_node.add_child(bullet)
	bullet.color = Color(1.0, 0.23, 0.23, 1.0)
	bullet.global_position = fire_hole.global_position
