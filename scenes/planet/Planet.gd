extends RigidBody3D

@export var rotation_speed: float = -0.5  # Adjust rotation speed as needed
@export var rotation_speed_increase: float = 1.2

func _physics_process(delta: float) -> void:
	print(rotation_degrees.x)
	rotate_x(rotation_speed * delta)  # Rotate around the X-axis
	
	# Every 90 degrees
	if roundi(rotation_degrees.x) % 90 == 0:
		SignalBus.score.emit()
		score(delta)
			
func _on_wall_body_entered(body: Node) -> void:
	if (body.name == "Player"):
		game_over()
		
func _on_wall_2_body_entered(body: Node) -> void:
	if (body.name == "Player"):
		game_over()
		
func score(delta: float) -> void:
	rotation_speed -= (rotation_speed_increase * delta)
	SignalBus.current_planet_rotation.emit(rotation_speed)
	SignalBus.shuffle_walls.emit(rotation_speed)

func game_over() -> void:
	SignalBus.game_over.emit()
	get_tree().call_deferred("reload_current_scene")
