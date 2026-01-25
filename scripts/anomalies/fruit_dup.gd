extends AnomalyEvent

func perform():
	print("fruit dup")
	var special_fruit := world.get_tree().get_first_node_in_group("special_fruit")
	special_fruit.start_dupe()

func cleanup():
	var special_fruit := world.get_tree().get_first_node_in_group("special_fruit")
	special_fruit.end_dupe()
	
