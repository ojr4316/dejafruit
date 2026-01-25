extends AnomalyEvent

func perform():
	print("shelves")
	var shelves := world.get_tree().get_nodes_in_group("shelf")
	for s in shelves:
		s.empty_shelf()
		
func cleanup():
	var shelves := world.get_tree().get_nodes_in_group("shelf")
	for s in shelves:
		s.init()
