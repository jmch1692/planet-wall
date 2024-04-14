extends RigidBody3D

@export var rotation_speed = -0.5  # Adjust rotation speed as needed

var game_over : bool = false

func _physics_process(delta):
	var planet_rotation = rotation_speed * delta
	rotate_x(planet_rotation)  # Rotate around the X-axis
	
	if !game_over:
		# Finalized the first lap + 1 degree
		#TODO: Check if value in degrees is between 90 and 91
		if rotation_degrees.x == -91:
			SignalBus.score.emit()
			score()
		elif rotation_degrees.x == 91: #another lap + 1 degree
			SignalBus.score.emit()
			score()

func _on_wall_body_entered(body):
	if (body.name == "Player"):
		game_over = true
		SignalBus.game_over.emit()
		get_tree().reload_current_scene()
		
func score():
	rotation_speed += -0.1
	SignalBus.current_planet_rotation.emit(rotation_speed)
