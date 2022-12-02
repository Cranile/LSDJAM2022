extends Node



var player;

# Called when the node enters the scene tree for the first time.
func _ready():
	print("global")

	pass # Replace with function body.

func openMenu():
	mainMenu.openMenu()
	topViewport.gui_disable_input = true
	print("open menu request")
func closeMenu():
	mainMenu.closeMenu()
	print("close menu request")


func _input(event):
	if (player == null):
		player = PSXLayer.getPlayer();

	#openCloseMenu
	if Input.is_action_just_pressed("escape"):
		if(Input.mouse_mode == Input.MOUSE_MODE_CAPTURED):
			openMenu()
			player.prevent_move = true
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			closeMenu()
			player.prevent_move = false
			Input.mouse_mode= Input.MOUSE_MODE_CAPTURED
