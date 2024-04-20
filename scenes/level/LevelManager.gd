extends Node3D

@onready var debug_label: Label = %PlanetRotationLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.current_planet_rotation.connect(_on_planet_rotation_changed.bind())
	SignalBus.score.connect(_on_score)

func _on_planet_rotation_changed(rotation_speed: float) -> void:
	debug_label.text = "Planet rotation: " + str(rotation_speed)
	
func _on_score() -> void:
	print("score")
