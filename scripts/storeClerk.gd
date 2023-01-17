extends prop

func _ready():
	pass # Replace with function body.

func updateState():
	dialogueIndex = 1

func taskDone():
	if(dialogueIndex == 1):
		main.itemBought()
		get_parent().storeStatusManager(false)
		print("item bought")
