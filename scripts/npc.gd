class_name NPC extends CharacterBody3D

@export var look_at_player := false
@export var default_animation := "idle"

@onready var ap: AnimationPlayer = $AnimationPlayer
@onready var vision: Area3D = $Vision
@onready var look_at_mod: LookAtModifier3D = $Root/Skeleton3D/LookAtModifier3D
@onready var check_vision: Timer = $CheckVision

# TODO: dynamic pathing / chase player
var static_pathing: PathFollow3D

@export var walk_speed := 1.5
@export var run_speed := 3.2
@export var walking := true

func _ready():
	if look_at_player:
		check_vision.start()
	play()
	
	# Don't hate me I'm right
	if get_parent() is PathFollow3D:
		static_pathing = get_parent()
		play("walk")

func play(anim=default_animation):
	ap.play("NPC_animations/" + anim)
	
func _on_check_vision_timeout() -> void:
	var bodies = vision.get_overlapping_bodies()
	for body in bodies:
		if body is Player:
			look_at_mod.target_node = body.camera.get_path()
		else:
			look_at_mod.target_node = ""
			
func _physics_process(delta: float) -> void:
	if static_pathing != null:
		static_pathing.progress += delta
