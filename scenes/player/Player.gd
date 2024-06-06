extends CharacterBody3D

@export var movement_speed: float = 7.5
@export var acceleration : float = 3.0
@export var jump_velocity : float = 10.0
@export var gravity: float = 22.5
@export var movement_dir: float = 0.0

@onready var animation_player : AnimationPlayer = %Rogue_Hooded.get_node("AnimationPlayer")
@onready var rig : Node3D = %Rogue_Hooded.get_node("Rig")
@onready var raycast : RayCast3D = %PlayerRayCast3D

func _ready() -> void:
	animation_player.get_animation("Running_A").loop = true
	animation_player.play("Running_A")
	SignalBus.shuffle_finished.connect(_on_shuffle_finished)
	
func _on_shuffle_finished() -> void:
	raycast.successfully_jumped = false

func get_move_input(delta: float) -> void:
	var vertical_y: float = velocity.y
	velocity.y = 0
	movement_dir = Input.get_axis("right", "left")
	var direction: Vector3 = Vector3(movement_dir, 0, 0).normalized()  # Set the y and z components to 0
	velocity = lerp(velocity, direction * movement_speed, acceleration * delta)
	velocity.y = vertical_y
	
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = jump_velocity
		
func _physics_process(delta: float) -> void:
	velocity.y -= gravity * delta
	get_move_input(delta)
	
	move_and_slide()
	
func reposition() -> void:
	transform.origin.x = -transform.origin.x

func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	reposition()
