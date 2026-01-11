extends Node3D

@onready var timer: Timer = $Timer
@onready var apple: RigidBody3D = $SI_Food_Organic_Apple_04_col

const spawn_delay := 0.4
const spawn_limit := 300
var spawned := -1

func _ready():
	apple.freeze = true

func _on_timer_timeout() -> void:
	if spawned > 0:
		var new_apple = apple.duplicate()
		add_child(new_apple)
		new_apple.freeze = false
		new_apple.global_position = global_position + Vector3((randf()-0.5)/5, 0.001, (randf()-0.5)/5)
		new_apple.add_to_group("spawned")
	spawned+=1
	if spawned < spawn_limit:
		timer.start(spawn_delay)

func end_dupe():
	timer.stop()
	var spawns := get_tree().get_nodes_in_group("spawned")
	for s in spawns:
		s.queue_free()

func start_dupe():
	timer.start(1)
