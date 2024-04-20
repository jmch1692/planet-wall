extends CharacterBody3D

@export var movement_speed: float = 7.5
const ACCELERATION = 5.0
const JUMP_VELOCITY = 10.0

var gravity: float = 22.5
var movement_dir: float = 0.0

@onready var animation_player : AnimationPlayer = %Rogue_Hooded.get_node("AnimationPlayer")
@onready var rig : Node3D = %Rogue_Hooded.get_node("Rig")

func _ready() -> void:
	animation_player.get_animation("Running_A").loop = true
	animation_player.play("Running_A")

func get_move_input(delta: float) -> void:
	var vertical_y: float = velocity.y
	velocity.y = 0
	movement_dir = 	Input.get_axis("right", "left")
	var direction: Vector3 = Vector3(movement_dir, 0, 0)  # Set the y and z components to 0
	velocity = lerp(velocity, direction * movement_speed, ACCELERATION * delta)
	velocity.y = vertical_y
	
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = JUMP_VELOCITY
		
func _physics_process(delta: float) -> void:
	velocity.y -= gravity * delta
	get_move_input(delta)
	
	move_and_slide()
