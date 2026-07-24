@tool
extends WeaponNode

class_name EightgunNode

func _bullet_angle_spawn_method(idx: int) -> float:
	
	if stats.bullets_per_shot > 1:
		return TAU * float(idx)/stats.bullets_per_shot
	else:
		return 0.0

func _set_bullet_rotation(bullet: BulletNode, angle := 0.0) -> void:
	bullet.global_rotation = muzzle.global_rotation + angle

func _set_bullet_spawn(bullet: BulletNode, _idx := 0) -> void:
	
	var local_offset := muzzle.position
	
	var spawn_offset := local_offset.rotated(bullet.global_rotation)
	
	bullet.global_position = global_position + spawn_offset.rotated(global_rotation)
