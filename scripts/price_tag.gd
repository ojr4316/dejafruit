class_name PriceTag extends Label3D

@export var default_price := 4.99

@onready var dollars: Label3D = $dollars
@onready var cents: Label3D = $dollars/cents

func _ready():
	set_price()

func set_price(price=default_price):
	var dols = int(price)
	dollars.text = str(dols)
	var cen = int(100*(price-dols))
	if cen > 10:
		cen = str(cen)
	elif cen > 0:
		cen = "0" + str(cen)
	else:
		cen = "00"
	
	cents.text = "." + cen
	
