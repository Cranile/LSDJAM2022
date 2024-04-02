extends prop



func _ready():
	playAnimation()
	pass # Replace with function body.


func playAnimation():
	$shroom2/AnimationPlayer.play("idleShroom2")
	$shroom2/AnimationPlayer.get_animation("idleShroom2").loop = true
	
