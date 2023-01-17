extends Spatial

var figures = []
onready var main = get_node("/root/main")
func _ready():
	figures = get_tree().get_nodes_in_group("figures")
	if (main.figurine != 0):
		disableFiguresInteraction()
	else:
		main.connect("figureCollected",self,"disableFiguresInteraction")
	pass #

func disableFiguresInteraction():
	print("call disable")
	for figure in figures:
		figure.disableInteraction()
