extends AnomalyEvent

func perform():
	var price_tags := world.get_tree().get_nodes_in_group("price_tag")
	for tag in price_tags:
		tag.set_price(6.66)
		
func cleanup():
	var price_tags := world.get_tree().get_nodes_in_group("price_tag")
	for tag in price_tags:
		tag.set_price()
