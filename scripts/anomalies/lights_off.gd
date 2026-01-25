extends AnomalyEvent

func perform():
	print("lightsss")
	var lights := world.get_tree().get_nodes_in_group("light")
	for light in lights:
		light.off()

func cleanup():
	var lights := world.get_tree().get_nodes_in_group("light")
	for light in lights:
		light.on()
