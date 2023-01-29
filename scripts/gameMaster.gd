extends Node

export var debugMode = false

onready var mapContainer = get_node("%mapContainer") #save the node that will contain the current map
export var scenesList = ["res://scenes/maps/testChamber.tscn"]
##export var test : PackedScene
var scene  #the first scene on the game

signal figureCollected
export var figurine = 0 ## what character did the player choose?
export var currentDay = 1 ## what day is the player in
var isDream = false

var dailyTaskAmmount = [3,3,2] ##how many task you have to complete per day to go to sleep
var currentDayProgress = 1
var tasksFinished = false

signal bedUpdate(boolean)
var currentLevel; #holds the level the player is currently in

export var levelIndex = 0;

var mouse_sensitivity = 0.05;

var player;
var mainMenu;
var PSXLayer;
var topViewport;
var mapController;

func _ready():
	mainMenu = get_node("GUIlayer")
	PSXLayer = get_node("PSXLayer")
	topViewport = get_node("PSXLayer/BlurPostProcess/Viewport")
	changeMap(levelIndex)
	
func _input(_event):
	if Input.is_action_just_pressed("escape"):
		handleUI()
		mainMenu.menuToggle()
	if Input.is_action_just_pressed("unstuck"):
		unstuck()

func changeMap(index):
	tasksFinished = false
	currentDayProgress = 1
	if(index == -1 || index > scenesList.size()):
		print("invalid index")
		return;
	
	levelIndex = index
	if(currentLevel != null):
		var level = mapContainer.get_child(0)
		mapContainer.remove_child(level)
		level.call_deferred("free")
	
	scene = load(scenesList[levelIndex])
	currentLevel = scene.instance();
	mapContainer.add_child(currentLevel)
	
	if !isDream:
		mapController = mapContainer.get_child(0)
		questUpdater()
	else:
		
		mapController = null
	

func goToSleep():
	##check if map is dream
	if (isDream == false):
		isDream = true
		changeMap(currentDay)
	else:
		isDream = false
		currentDay +=1
		changeMap(0)
		questUpdater()
	##if dream 1 up the day counter 
	##change map

func setPlayer(param):
	player = param
	player.connect("crossHairActive", self, "crossHairChange")
	player.connect("eyelidsState",mainMenu,"eyelidsUpdate")
	mainMenu.connect("lidState",player,"lidsUpdated")
	player.canBlink = isDream
	setSensitivity()
	if debugMode:
		player.connect("interactableName",mainMenu,"debugLabelUpdate")
		pass

func getPlayer():
	return player;

func setSensitivity():
	player.mouse_sens = mouse_sensitivity
func getSensitivity():
	return mouse_sensitivity;

func handleUI():
	if player == null:
		return
	if(topViewport.gui_disable_input == false):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		player.prevent_move = true
		topViewport.gui_disable_input = true
	else:
		Input.mouse_mode= Input.MOUSE_MODE_CAPTURED
		player.prevent_move = false
		topViewport.gui_disable_input = false

func unstuck():
	Input.mouse_mode= Input.MOUSE_MODE_CAPTURED
	player.prevent_move = false
	topViewport.gui_disable_input = false
func inputToogle(state):
	##go to the top viewport and disable/enable the option for input
	##this will prevent the player for moving but will allow the UI to grab input
	topViewport.gui_disable_input = state

func crossHairChange(type):
	mainMenu.changeCrossHair(type)

func queueNewDialogue(timelineName):
	mainMenu.newDialogue(timelineName)
	handleUI()

func figureUpdate(selectionINT):
	figurine = selectionINT
	emit_signal("figureCollected")
	currentDayProgress +=1
	questUpdater()

func itemBought():
	currentDayProgress +=1
	questUpdater()

func interactPC():
	##called when player gets to interact with the pc on day 1
	if (currentDay == 1 || currentDay == 2 ):
		if (currentDayProgress == 2 ):
			currentDayProgress +=1
			questUpdater()
		if (currentDayProgress >= 2):
			mainMenu.openPCUi()

func rainTrigger():	
	if (currentDayProgress == 1):
		currentDayProgress +=1
		questUpdater()

func questUpdater():
	if(currentDay > dailyTaskAmmount.size()):
		print("Fin")
		return;
	if(currentDay == 1 && figurine == 0):
		player.currentAmbience(0)
		mapController.introTriggerEnabled()
	if(currentDay == 2 && currentDayProgress < 2):
		player.currentAmbience(0)
		mapController.day2ITriggerEnabled()
		mapController.updateStoreInteraction(true)
		mainMenu.swapPC()
	
	if(currentDay == 3):
		player.currentAmbience(1)
		##enable storm and trigger on house
		if mapController == null:
			mapController = mapContainer.get_child(0)
		mapController.enableDay3Quest()
	##check if maximum is reach
	##add new task
	##OR
	##emmit signal
	if(currentDayProgress >= dailyTaskAmmount[currentDay - 1]):
		tasksFinished = true
		emit_signal("bedUpdate",tasksFinished)
		return

