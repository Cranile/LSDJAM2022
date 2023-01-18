extends Spatial

onready var clerk = $storeClerk

func _ready():
	storeStatusManager(false)

func storeStatusManager(booleanState):
	var children = get_children()
	if (booleanState):

		for child in children:
			child.enableInteraction()
	else:

		for child in children:
			child.disableInteraction()

func itemObtained():
	clerk.updateState()
