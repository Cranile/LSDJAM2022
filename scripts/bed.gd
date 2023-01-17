extends prop

func _ready():
	main.connect("bedUpdate",self,"updateBedState")
	
func updateBedState(state):
	if state:
		print("task done recieved")
		dialogueIndex = 1
	else:
		print("new task assigned recieved")
		dialogueIndex = 0
	print("bed updated")
