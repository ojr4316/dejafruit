class_name World extends Node
# Given to anomalies to modify/add/subtract

@export var loop_tomato: LoopTomato
@onready var clock: Clock = $Clock

@onready var bakery_loop: PathFollow3D = $npc_paths/BakeryAisleLoop/PathFollow3D
@onready var alcohol_loop: PathFollow3D = $npc_paths/AlcoholLoop/PathFollow3D

func reset():
	bakery_loop.progress_ratio = 0.0
	alcohol_loop.progress_ratio = 0.0
	loop_tomato.visible = true
	loop_tomato.pickup = false
