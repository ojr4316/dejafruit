class_name ATMSpit extends AnomalyEvent

func perform():
	var atm = world.get_tree().get_first_node_in_group("atm")
	atm.start()
		
func cleanup():
	var atm = world.get_tree().get_first_node_in_group("atm")
	atm.end()
