extends TextureRect

onready var default = load("res://textures/UI/point.png")
onready var grab = load("res://textures/UI/grab2.png")
onready var exit = load("res://textures/UI/exit2.png")
onready var interact = load("res://textures/UI/interact2.png")

var currentType;
func _ready():
	changeCrosshair("default")

func changeCrosshair(type):
	
	if( currentType == type || typeof(type) != 4):
		return;
	if( type == "default"):
		set_texture(default)
	elif( type == "interact"):
		set_texture(interact)
	elif( type == "grab"):
		set_texture(grab)
	elif( type == "exit"):
		set_texture(exit)
