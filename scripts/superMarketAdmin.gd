extends Spatial

onready var clerk = $storeClerk

func _ready():
	storeStatusManager(false)

func storeStatusManager(booleanState):
	var children = get_children()
	if (booleanState):
		print("disable all collision for store")
		for child in children:
			child.enableInteraction()
	else:
		print("enable all collision for store")
		for child in children:
			child.disableInteraction()

func itemObtained():
	clerk.updateState()
