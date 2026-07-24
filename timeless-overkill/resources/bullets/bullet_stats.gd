@tool
extends IdentifiedResource
class_name BulletStats

@export var speed: float
@export var damage: float
@export var texture: Texture2D
@export var bounces: LimitedValue

@export_file("*.tscn") var scene: String
