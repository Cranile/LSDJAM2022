extends StaticBody
class_name prop

export var propName = "prop name"

export var hasMapchange = false
export var newMapIndex = -1

export var haspickup = false
export var deleteOnPickup = false

export var hasOpen = false

export var hasDialogue = false
export var dialogueIndex = 0
export var dialogues = [""]

export var hasCustomMethod = false
export var methodName = ""

var main 
func _ready():
		main = get_node("/root/main")
		pass # Replace with function body.

func getMapIndex():
	return newMapIndex

func interactionType():
	if hasMapchange :
		return "exit"
	elif haspickup :
		return "grab"
	else :
		return "interact"
func interaction():
	
	print("interacting with prop: ",propName)
	if(hasMapchange):
		main.changeMap(newMapIndex)
		print("mapChange")
	if(hasOpen):
		print("open")
	if(haspickup):
		print("pickup")
		if(deleteOnPickup):
			deleteSelf()
	if(hasDialogue):
		main.queueNewDialogue(dialogues[dialogueIndex])
		print("dialogue")
	if(hasCustomMethod):
		if !(has_method(methodName)) :
			return
		call_deferred(methodName)

func deleteSelf():
	queue_free()
	print("delete self")

func disableInteraction():
	print("disable interaction")
	get_node("CollisionShape").set_deferred("disabled",true)

