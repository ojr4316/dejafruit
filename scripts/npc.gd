class_name NPC extends CharacterBody3D

@export var look_at_player := false
@onready var init_look_at_player := look_at_player
@export var default_animation := "idle"
@onready var init_animation := default_animation

@onready var ap: AnimationPlayer = $AnimationPlayer
@onready var vision: Area3D = $Vision
@onready var look_at_mod: LookAtModifier3D = $Root/Skeleton3D/LookAtModifier3D
@onready var check_vision: Timer = $CheckVision

# TODO: dynamic pathing / chase player
@export var static_pathing: PathFollow3D
@export var walk_speed := 1.5
@export var run_speed := 3.2
@export var walking := true

func _ready():
	add_to_group("npc")
	if look_at_player:
		check_vision.start()
	play()
	
	if static_pathing != null:
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

func reset_look_at_player():
	look_at_player = init_look_at_player
	
func disable_face():
	var faceless: MeshInstance3D = $Root/Skeleton3D/faceless
	var normal: MeshInstance3D = $Root/Skeleton3D/SK_Chr_Cook_Male_01
	faceless.visible = true
	normal.visible = false

func enable_face():
	var faceless: MeshInstance3D = $Root/Skeleton3D/faceless
	var normal: MeshInstance3D = $Root/Skeleton3D/SK_Chr_Cook_Male_01
	faceless.visible = false
	normal.visible = true
