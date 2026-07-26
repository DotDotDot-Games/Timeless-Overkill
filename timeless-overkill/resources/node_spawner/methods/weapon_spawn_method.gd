extends BaseRegistrySpawnMethod

class_name WeaponSpawnMethod

func create() -> PickableGun:
	
	var scene: PickableGun = load("res://scenes/guns/pickable_gun.tscn").instantiate()
	scene.data = DATABASE.load_entry(_IDS.pick_random()).duplicate(true)
	
	return scene
