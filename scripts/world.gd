class_name World extends Node

const WIN = preload("uid://1oeiarh1e408")
@export var loop_tomato: LoopTomato

@onready var store: Node3D = $store
@onready var clock: Clock = $store/Clock
@onready var bakery_loop: PathFollow3D = $store/npc_paths/BakeryAisleLoop/PathFollow3D
@onready var alcohol_loop: PathFollow3D = $store/npc_paths/AlcoholLoop/PathFollow3D


@onready var parking_lot: Node3D = $parking_lot

func _ready():
	store.visible = true
	parking_lot.visible = false

func reset():
	bakery_loop.progress_ratio = 0.0
	alcohol_loop.progress_ratio = 0.0
	loop_tomato.visible = true
	loop_tomato.pickup = false
	
func end():
	store.queue_free()
	parking_lot.visible = true
	await get_tree().create_timer(15.0).timeout
	get_tree().call_deferred("change_scene_to_packed", WIN)
