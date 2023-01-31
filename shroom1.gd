extends prop


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	playAnimation()
	pass # Replace with function body.


func playAnimation():
	$shroom1/AnimationPlayer.play("idleShroom1")
	$shroom1/AnimationPlayer.get_animation("idleShroom1").loop = true
	
