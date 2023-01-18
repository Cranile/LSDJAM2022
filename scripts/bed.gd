extends prop

func _ready():
	main.connect("bedUpdate",self,"updateBedState")
	
func updateBedState(state):
	if state:
		dialogueIndex = 1
	else:
		dialogueIndex = 0
