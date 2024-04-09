extends RigidBody3D

@export var rotation_speed = -0.001  # Adjust rotation speed as needed

func _physics_process(delta):
	# Make it rotate on the x axis, a bit every frame
	var rotation_increment = rotation_speed * delta
	rotate_x(rotation_speed)  # Rotate around the X-axis
