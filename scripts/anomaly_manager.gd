# Global AnomalyManager
extends Node

const ANOMALY_CHANCE = 0.6

var anomalies: Array[AnomalyEvent]
var current_anomaly: AnomalyEvent

var world_ref: World

var has_fruit := false
var did_purchase := false
var anomaly_present := false

var progress := 0
const win_state := 8

func _ready():
	load_anomalies()
	world_ref = get_tree().get_first_node_in_group("world")

func set_fruit(x: bool):
	has_fruit = x
	get_tree().get_first_node_in_group("checkout").enabled = x

func start_random():
	print("NEW CYCLE!")
	
	## If no anomaly, buy. If anomaly, leave
	
	# Evaluate last
	if (not anomaly_present and not did_purchase) or (did_purchase and anomaly_present):
		progress = 0
		print("MISSED! reset")
		get_tree().get_first_node_in_group("clock").set_percent_open_to_close(0)
	else:
		progress+=1
		get_tree().get_first_node_in_group("clock").set_percent_open_to_close(progress/8.0)

	# Check win
	if progress > win_state:
		world_ref.end()
		return

	# Reset world
	if current_anomaly != null:
		current_anomaly.cleanup()
		current_anomaly = null
	world_ref.reset()
	get_tree().get_first_node_in_group("checkout").enabled = false
	did_purchase = false
	has_fruit = false
	
	# New anomaly (or not)
	if anomalies.size() == 0:
		print("No anomalies left!")
		return
		
	if randf() < ANOMALY_CHANCE:
		anomaly_present = true
		var choice = anomalies.pick_random()
		print(choice)
		current_anomaly = choice
		anomalies.erase(choice)
		choice.world = world_ref
		choice.perform()
	
	else: # No anomaly
		anomaly_present = false
		print("none!")
	


## Anomaly scripts
const Atm = preload("uid://ndratg2ne42v")
const Dead = preload("uid://b37lea53v6f2")
const EmptyShelves = preload("uid://bkws1fb08b5ad")
const Faceless = preload("uid://bocfefga86apk")
const Flicker = preload("uid://bot45uo3j0bji")
const FruitDup = preload("uid://cwla8dwnq3qd4")
const FruitRotten = preload("uid://dubejy5e1yw27")
const LightsOff = preload("uid://d1xp7col22co2")
const NpcStare = preload("uid://8v1lylimtsv2")
const PriceTag = preload("uid://c8tmkgpxoengl")
const Scaled = preload("uid://covminjftru1u")
const MissingObjects = preload("uid://woy5usaw7buh")
const MissingPeople = preload("uid://bnybga53n4cfe")

func load_anomalies():
	var scripts = [Atm, Dead, EmptyShelves, Faceless, Flicker, FruitDup, FruitRotten,
	LightsOff, NpcStare, PriceTag, Scaled]
	## Load AnomalyEvent extended scripts into usable AnomalyEvent Resources
	for script in scripts:
		if script != null:
			var res = Resource.new()
			res.set_script(script)
			anomalies.append(res)
	print("Loaded ", anomalies.size(), " anomalies!")
