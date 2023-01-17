extends Area

export var hasMapchange = false
export var haspickup = false
export var hasOpen = false
export var hasDialogue = false

export var propName = "trigger name"
export var newMapIndex = -1

export var dialogueIndex = 0
export var dialogues = [""]

var main 
func _ready():
		main = get_node("/root/main")
		pass # Replace with function body.

func getMapIndex():
	return newMapIndex

func interaction():
	
	print("interacting with prop: ",propName)
	if(hasMapchange):
		main.changeMap(newMapIndex)
		print("mapChange")
	if(hasOpen):
		print("open")
	if(hasDialogue):
		main.queueNewDialogue(dialogues[dialogueIndex])
		print("dialogue")

func deleteSelf():
	queue_free()
	print("delete self")

func disableInteraction():
	print("disable interaction")
	get_node("CollisionShape").set_deferred("disabled",true)


func _on_trigger_body_entered(body):
	print(body, " entered")
	interaction()
	pass # Replace with function body.

