extends RigidBody3D

func _ready() -> void:
	SignalBus.shuffle_walls.connect(_on_suffle_walls.bind())

func _on_suffle_walls(rotation_speed: float) -> void:
	pass
