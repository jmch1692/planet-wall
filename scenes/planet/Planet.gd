extends RigidBody3D

@onready var timer : Timer = %Timer

@onready var smoke_particle_scene : PackedScene = preload("res://scenes/System/Particles/SmokeParticles.tscn")

@export var rotation_speed: float = -0.5  # Adjust rotation speed as needed
@export var rotation_speed_increase: float = 1.2

const initial_timer_value : float = 5.0

func _ready() -> void:
	timer.start(initial_timer_value - abs(rotation_speed))

func _physics_process(delta: float) -> void:
	rotate_x(rotation_speed * delta)  # Rotate around the X-axis
		
func score(delta: float) -> void:
	rotation_speed -= (rotation_speed_increase * delta)
	SignalBus.current_planet_rotation.emit(rotation_speed)
	SignalBus.score.emit()
	
func _on_timer_timeout() -> void:
	score(get_physics_process_delta_time())
	timer.start(initial_timer_value - abs(rotation_speed))

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("garbage"):
		if body.is_visible_on_screen:
			var smoke_scene : GPUParticles3D = smoke_particle_scene.instantiate()
			smoke_scene.transform.origin = body.transform.origin
			add_child(smoke_scene)

func _on_area_3d_body_exited(body: Node) -> void:
	if body.is_in_group("garbage"):
		SignalBus.garbage_exited_orbit.emit(body)
