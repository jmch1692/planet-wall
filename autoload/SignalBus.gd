extends Node

signal game_over()
signal score()

signal current_planet_rotation(rotation_speed: float)

signal shuffle_walls(collider: RigidBody3D)
signal shuffle_finished()

signal playerHitEphemeralCube()

signal garbage_exited_orbit(body: Node)
