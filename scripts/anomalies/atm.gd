extends AnomalyEvent

func perform():
	print("ATM SPIT")
	var atm = world.get_tree().get_first_node_in_group("atm")
	atm.start()
		
func cleanup():
	var atm = world.get_tree().get_first_node_in_group("atm")
	atm.end()
