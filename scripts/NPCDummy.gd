extends StaticBody

export var npcName = "name"
export var dialogueIndex = 0
export var dialogues = ["test","testChoice"]
var main ;
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func interaction():
	
	main.queueNewDialogue(dialogues[dialogueIndex])
	if(dialogueIndex + 1 < dialogues.size()):
		dialogueIndex += 1
# Called when the node enters the scene tree for the first time.
func _ready():
	main = get_node("/root").get_child(0);
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
