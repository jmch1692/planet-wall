extends RayCast3D

var successfully_jumped : bool = false

func _physics_process(_delta: float) -> void:
	if is_colliding() && successfully_jumped == false:
		var collider : RigidBody3D = get_collider() as RigidBody3D
		successfully_jumped = true
		await get_tree().create_timer(1.0).timeout
		SignalBus.shuffle_walls.emit(collider)
