extends Node

onready var mapContainer = get_node("%mapContainer") #save the node that will contain the current map
onready var firstScene =  load("res://scenes/maps/testChamber.tscn") #the first scene on the game

var levelList = []
var currentLevel; #holds the level the player is currently in

var levelIndex = 0;

var mouse_sensitivity = 0.03;

func _ready():
	if (mapContainer.get_child_count() != 0):
		print("has child")
		
	currentLevel = firstScene.instance();
	mapContainer.add_child(currentLevel)

func changeMap():
	print( mapContainer.get_children() )
	pass
