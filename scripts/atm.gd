class_name ATM extends Node3D

const MONEY = preload("uid://b5gpb6n0ck127")
@onready var timer: Timer = $Timer
@onready var spawn: Node3D = $spawn
@onready var deposit: AudioStreamPlayer3D = $deposit

const spawn_delay := 0.5
const spawn_limit := 150
var spawned := -1
var spit_velocity := 0.5
func _on_timer_timeout() -> void:
	if spawned > 0:
		var money = MONEY.instantiate()
		spawn.add_child(money)
		money.freeze = false
		money.global_position = spawn.global_position
		money.apply_impulse(Vector3(0, 1, spit_velocity))
		money.add_to_group("spawned")
		if spit_velocity < 8.0:
			spit_velocity += 0.05
	spawned+=1
	deposit.play()
	if spawned < spawn_limit:
		timer.start(spawn_delay)

func end():
	timer.stop()
	var spawns := get_tree().get_nodes_in_group("spawned")
	for s in spawns:
		s.queue_free()

func start():
	timer.start(1)
