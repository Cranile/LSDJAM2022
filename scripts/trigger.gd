extends Area
class_name trigger
export var propName = "trigger name"

export var hasMapchange = false
export var newMapIndex = -1
export var haspickup = false
export var hasOpen = false
export var hasDialogue = false

export var dialogueIndex = 0
export var dialogues = [""]

export var selfDisable = false
var currentDisableCount = 0
export var collisionCountToDisable = 1

export var customMethod = false
var main 
func _ready():
		main = get_node("/root/main")
		pass # Replace with function body.

func getMapIndex():
	return newMapIndex

func interaction():
	
	
	if(hasMapchange):
		main.changeMap(newMapIndex)
		
	if(hasOpen):
		print("open")
	if(hasDialogue):
		main.queueNewDialogue(dialogues[dialogueIndex])
		
	if(customMethod):
		extraMethod()
	if(selfDisable):
		currentDisableCount += 1
		if(currentDisableCount >= collisionCountToDisable):
			disableInteraction()
func deleteSelf():
	queue_free()
	

func disableInteraction():
	get_node("CollisionShape").set_deferred("disabled",true)

func enableInteraction():
	get_node("CollisionShape").set_deferred("disabled",false)

func extraMethod():
	print("generic extra method")
	pass

func _on_trigger_body_entered(body):
	
	interaction()
	pass # Replace with function body.

