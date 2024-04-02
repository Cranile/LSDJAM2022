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
	##enable rain sound for day 3
	##disable door d1 on pl house and enable door d3
	get_node("ViewportContainer/Viewport/map/plHouse/doorD1").set_deferred("visible",false)
	var doorD3 = get_node("ViewportContainer/Viewport/map/plHouse/doorD3")
	doorD3.set_deferred("visible",true)
	doorD3.get_child(1).get_child(0).disabled = false
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

func endDay():
	var endDay = get_node("ViewportContainer/Viewport/map/endDay")
	endDay.start()
