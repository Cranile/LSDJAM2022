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
	if(hasMapchange):
		main.changeMap(newMapIndex)
		
	if(hasOpen):
		print("open")
	if(haspickup):
		
		if(deleteOnPickup):
			deleteSelf()
	if(hasDialogue):
		main.queueNewDialogue(dialogues[dialogueIndex])
		
	if(hasCustomMethod):
		if !(has_method(methodName)) :
			return
		call_deferred(methodName)

func deleteSelf():
	queue_free()
	

func enableInteraction():
	get_node("CollisionShape").set_deferred("disabled",false)

func disableInteraction():
	get_node("CollisionShape").set_deferred("disabled",true)

func debugData():
	return ("name: "+var2str( propName)  +
	 "\n" + "mapChange? " + var2str(hasMapchange) + 
	 "\n" + "pickup? "+var2str(haspickup) +
	 "\n" + "dialogue? " + var2str(hasDialogue) +
	 "\n" + "customMethod? " + var2str(hasCustomMethod))
