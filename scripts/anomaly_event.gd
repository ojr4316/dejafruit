@abstract class_name AnomalyEvent extends Resource

var world: World

@abstract func perform() # Called on start, create scenes
#@abstract func active() # Called continuously
@abstract func cleanup() # Remove anomaly, return normal functionality

## examples
"""

# 6. Distorted music
func music_perform():
	pass
	# TODO: Access global manager

# 7. Whispers from the aisle over
func whisper_perform():
	pass
	# TODO: spawn a audio that moves around scene/near player

# 8. All prices are $6.66
func prices_perform():
	var price_tags := get_tree().get_nodes_in_group("price_tag")
	for tag in price_tags:
		tag.set_text("$6.66")

# 9. Silly sign changed ("DIET"=>"DIE")
func sign_perform():
	var sign = get_tree().get_first_node_in_group("die_sign")
	sign.set_text("DIE") # CLEANUP sign.set_text(default?)

# 10. Empty shelves
func shelves_perform():
	var shelves = get_tree().get_nodes_in_group("shelf")
	for shelf in shelves:
		shelf.hide_items() # shelf.show_items()
		
# 11. Player/world slightly scaled
func scale_perform():
	var player = get_tree().get_first_node_in_group("player")

# 12. Creepy poster
func poster_perform():
	pass # find poster, modify

# 13. More/less wet floor
func wet_floor_perform():
	pass # Add wet floor signs
	
# 14. Small box with a pulsing light and beeping noise
func box_perform():
	pass # add
	
# 15. Cashier missing face


# 16. Customer service missing
# 17. Fruit is meat
# 18. Backroom door is ajar, on view => Jumpscare
# 19. Props blocking aisles are removed
# 20. Leak/Room fills with water
# 21. Explosion sound => Blackout => Emergency lights
# 22. All fruit is tomatoes.
# 23. Person following you
# 24. Slippery floor
# 25. Recently knocked down random food
# 26. Everyone is dead on the ground
# 27. Infinite money from ATM
"""
