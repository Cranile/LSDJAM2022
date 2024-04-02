extends Spatial

var dreamID = 3
var wave
onready var main = get_node("/root/main")
onready var animator = get_node("ViewportContainer/Viewport/skybox/AnimationPlayer")
onready var roomAnim = get_node("ViewportContainer/Viewport/map/roomAnimator")
func getDreamID():
	return dreamID

# Called when the node enters the scene tree for the first time.
func _ready():
	main.enableMusic("rain")
	wave = get_node("ViewportContainer/Viewport/skybox/slybox")
	pass # Replace with function body.

func endScene():
	##play 
	animator.play("wave")
	roomAnim.play("shake")
	main.enableMusic("strong")
	wave.visible = true


func _on_AnimationPlayer_animation_finished(anim_name):
	main.goToSleep()
	pass # Replace with function body.
