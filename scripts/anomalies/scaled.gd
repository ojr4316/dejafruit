extends AnomalyEvent

var tween: Tween
func perform():
	print("scaling down")
	var player = world.get_tree().get_first_node_in_group("player")
	tween = world.get_tree().create_tween()
	tween.tween_property(player, "scale", Vector3(0.9, 0.9, 0.9), 10)
		
func cleanup():
	tween.stop()
	var player = world.get_tree().get_first_node_in_group("player")
	player.scale = Vector3.ONE
