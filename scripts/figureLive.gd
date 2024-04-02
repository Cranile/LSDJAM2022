extends Spatial

export var animNames = ["","",""]
var animation
onready var animator = $AnimationPlayer
var doesLoop = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func playAnimation(animType):
	doesLoop = true
	##idle
	if(animType == "idle"):
		animation = animNames[0]
	##walk
	if(animType == "walk"):
		animation = animNames[1]
	##wave
	if(animType == "wave"):
		animation = animNames[2]
		doesLoop = false
	
	animator.play(animation)
	animator.get_animation(animation).loop = doesLoop


func _on_AnimationPlayer_animation_finished(anim_name):
	
	if(anim_name == animNames[2]):
		playAnimation("idle")
	pass # Replace with function body.
