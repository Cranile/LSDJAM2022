extends Spatial

var figures = []
onready var main = get_node("/root/main")
var superMarket
func _ready():
	main.mapController = self
	superMarket = $ViewportContainer/Viewport/map/interactableProps/superMarket
	figures = get_tree().get_nodes_in_group("figures")
	if (main.figurine != 0):
		disableFiguresInteraction()
	else:
		main.connect("figureCollected",self,"disableFiguresInteraction")
	introTriggerDisabled()
	day2IntroTriggerDisabled()
	if(main.currentDay != 3):
		disableDay3Quest()


func disableFiguresInteraction():
	
	for figure in figures:
		figure.disableInteraction()

func updateStoreInteraction(state):
	superMarket.storeStatusManager(state)

func enableDay3Quest():
	var day3 = $ViewportContainer/Viewport/map/interactableProps/day3
	for prop in day3.get_children():
		prop.enableInteraction()
func disableDay3Quest():
	var day3 = $ViewportContainer/Viewport/map/interactableProps/day3
	for prop in day3.get_children():
		prop.disableInteraction()

func introTriggerDisabled():
	$ViewportContainer/Viewport/map/interactableProps/startTrigger.disableInteraction()
func introTriggerEnabled():
	$ViewportContainer/Viewport/map/interactableProps/startTrigger.enableInteraction()

func day2IntroTriggerDisabled():
	$ViewportContainer/Viewport/map/interactableProps/day2Intro.disableInteraction()
func day2ITriggerEnabled():
	$ViewportContainer/Viewport/map/interactableProps/day2Intro.enableInteraction()
