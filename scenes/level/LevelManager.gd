extends Node3D

const MAX_GARBAGE_LIMIT : int = 15

@onready var debug_label: Label = %PlanetRotationLabel
@onready var space_garbage_scence : Array[PackedScene] = [
	preload("res://scenes/SpaceGarbage/Drill.tscn"),
	preload("res://scenes/SpaceGarbage/Truck.tscn"),
	preload("res://scenes/SpaceGarbage/SolarPanel.tscn"),
	preload("res://scenes/SpaceGarbage/WindTurbine.tscn")
]
@onready var player : CharacterBody3D = %Player

@onready var planet : RigidBody3D = %Planet

var garbage_in_planet : Array[RigidBody3D]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.current_planet_rotation.connect(_on_planet_rotation_changed.bind())
	SignalBus.score.connect(_on_score)
	SignalBus.game_over.connect(_on_game_over)
	SignalBus.garbage_exited_orbit.connect(_on_garbage_exited_orbit.bind())

func _on_planet_rotation_changed(rotation_speed: float) -> void:
	debug_label.text = "Planet rotation: " + str(rotation_speed)
	
func _on_score() -> void:
	var garbage : RigidBody3D = space_garbage_scence.pick_random().instantiate() as RigidBody3D
	garbage.transform.origin = Vector3(randi_range(-50, 50), randi_range(85, 100), -50)
	garbage.apply_impulse(garbage.transform.origin.direction_to(player.transform.origin), Vector3.ZERO)
	planet.add_child(garbage)
	garbage_in_planet.append(garbage)
	print("Garbage objects in orbit: %s" % garbage_in_planet.size())
	if garbage_in_planet.size() >= MAX_GARBAGE_LIMIT:
		var aged_garbage : RigidBody3D = garbage_in_planet.pop_front()
		if aged_garbage.is_visible_on_screen:
			aged_garbage.queue_free()
	
func _on_game_over() -> void:
	get_tree().call_deferred("reload_current_scene")
	
func _on_garbage_exited_orbit(body: Node) -> void:
	print_rich("[color=green]%s has left the orbit. Deleting it..." % body.name)
	body.call_deferred("queue_free")
