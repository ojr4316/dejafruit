class_name FruitRotten extends AnomalyEvent

func perform():
	print("ROOTTT!")
	var fruits := world.get_tree().get_nodes_in_group("fruit")
	for fruit in fruits:
		fruit.rot()

func cleanup():
	var fruits := world.get_tree().get_nodes_in_group("fruit")
	for fruit in fruits:
		fruit.reset()
