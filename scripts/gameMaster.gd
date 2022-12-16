extends Node

onready var mapContainer = get_node("%mapContainer") #save the node that will contain the current map
onready var firstScene =  load("res://scenes/maps/testChamber.tscn") #the first scene on the game

var levelList = []
var currentLevel; #holds the level the player is currently in

var levelIndex = 0;

var mouse_sensitivity = 0.05;

var player;
var mainMenu;
var PSXLayer;
var topViewport;
func _ready():
	print("main ready")
	if (mapContainer.get_child_count() != 0):
		print("has child")
	
	mainMenu = get_node("GUIlayer")
	PSXLayer = get_node("PSXLayer")
	topViewport = get_node("PSXLayer/BlurPostProcess/Viewport")
	currentLevel = firstScene.instance();
	mapContainer.add_child(currentLevel)
	
func _input(event):
	if Input.is_action_just_pressed("escape"):
		if(Input.mouse_mode == Input.MOUSE_MODE_CAPTURED):
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			player.prevent_move = true
		else:
			Input.mouse_mode= Input.MOUSE_MODE_CAPTURED
			player.prevent_move = false
		inputToogle()
		
		mainMenu.menuToggle()

func changeMap():
	print( mapContainer.get_children() )
	pass

func setPlayer(param):
	player = param
	setSensitivity()
func getPlayer():
	return player;

func setSensitivity():
	player.mouse_sens = mouse_sensitivity
func getSensitivity():
	return mouse_sensitivity;

func inputToogle():
	##go to the top viewport and disable/enable the option for input
	##this will prevent the player for moving but will allow the UI to grab input
	topViewport.gui_disable_input = !topViewport.gui_disable_input
