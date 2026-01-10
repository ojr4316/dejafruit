class_name Player extends CharacterBody3D
## 3rd person
#@onready var camera_pivot: Node3D = $CameraPivot
#@onready var spring_arm: SpringArm3D = $CameraPivot/SpringArm3D

@onready var ui: UI = $UI

@onready var camera: Camera3D = $Camera3D
@onready var mesh_root: Node3D = $Root

@export var jump_strength := 3.5
@export var gravity := 10

@export var default_move_speed := 3.0
@onready var move_speed := default_move_speed
@export var move_acc := 2.0
@export var move_dec := 10.0

@export var mouse_sensitivity := 0.01
@export var tilt_limit = deg_to_rad(75)

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	
	var dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var move := dir.x*global_transform.basis.x+dir.y*global_transform.basis.z
	
	# Change directions faster
	if (move.x > 0 and velocity.x < 0) or (move.x < 0 and velocity.x > 0):
		velocity.x = 0
	if (move.z > 0 and velocity.z < 0) or (move.z < 0 and velocity.z > 0):
		velocity.z = 0
	
	if dir.x > 0:
		velocity.x = move_toward(velocity.x, move.x * move_speed, delta * move_acc)
	else:
		velocity.x = move_toward(velocity.x, move.x * move_speed, delta * move_dec)
	if dir.y > 0:
		velocity.z = move_toward(velocity.z, move.z * move_speed, delta * move_acc)
	else:
		velocity.z = move_toward(velocity.z, move.z * move_speed, delta * move_dec)
	
	#mesh_root.rotation.y = lerp_angle(mesh_root.rotation.y, camera_pivot.rotation.y - PI, delta * 10.0)
	
	if is_on_floor():
		velocity.y = 0
		if Input.is_action_just_pressed("jump"):
			velocity.y += jump_strength
	else:
		velocity.y -= gravity * delta
		
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	elif event is InputEventMouseButton:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	elif Input.mouse_mode == Input.MOUSE_MODE_CAPTURED and event is InputEventMouseMotion:
		## 3rd person
		#camera_pivot.rotation.x -= event.relative.y * mouse_sensitivity
		#camera_pivot.rotation.x = clampf(camera_pivot.rotation.x, -tilt_limit, tilt_limit)
		#camera_pivot.rotation.y += -event.relative.x * mouse_sensitivity
		rotate_y(-event.relative.x * mouse_sensitivity)
		camera.rotate_x(-event.relative.y * mouse_sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)
