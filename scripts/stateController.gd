extends Spatial

var figures = []
onready var main = get_node("/root/main")
var superMarket
func _ready():
	superMarket = $ViewportContainer/Viewport/map/interactableProps/superMarket
	figures = get_tree().get_nodes_in_group("figures")
	if (main.figurine != 0):
		disableFiguresInteraction()
	else:
		main.connect("figureCollected",self,"disableFiguresInteraction")
	

func disableFiguresInteraction():
	print("call disable")
	for figure in figures:
		figure.disableInteraction()

func updateStoreInteraction(state):
	superMarket.storeStatusManager(state)
