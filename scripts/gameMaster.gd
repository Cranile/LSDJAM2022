extends Node

export var debugMode = false

onready var mapContainer = get_node("%mapContainer") #save the node that will contain the current map
export var scenesList = ["res://scenes/maps/testChamber.tscn"]
##export var test : PackedScene
var scene  #the first scene on the game

signal figureCollected
var figurine = 0 ## what character did the player choose?
var currentDay = 1 ## what day is the player in
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
	print("main ready")
	if (mapContainer.get_child_count() != 0):
		print("has child")
	
	mainMenu = get_node("GUIlayer")
	PSXLayer = get_node("PSXLayer")
	topViewport = get_node("PSXLayer/BlurPostProcess/Viewport")
	changeMap(levelIndex)
	
func _input(_event):
	if Input.is_action_just_pressed("escape"):
		handleUI()
		mainMenu.menuToggle()

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
	print("new level ", levelIndex)
	if !isDream:
		mapController = mapContainer.get_child(0)
		questUpdater()
	else:
		mapController = null
	pass

func goToSleep():
	print("new day")
	##check if map is dream
	if (isDream == false):
		print("now is dream")
		isDream = true
		changeMap(currentDay)
	else:
		isDream = false
		currentDay +=1
		print("to day ",currentDay)
		questUpdater()
		changeMap(0)
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

func inputToogle(state):
	##go to the top viewport and disable/enable the option for input
	##this will prevent the player for moving but will allow the UI to grab input
	topViewport.gui_disable_input = state

func crossHairChange(type):
	
	mainMenu.changeCrossHair(type)

func queueNewDialogue(timelineName):
	mainMenu.newDialogue(timelineName)
	handleUI()
	print("create new dialogue")

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
	print("pc interact")
	if (currentDay == 1 || currentDay == 2 ):
		if (currentDayProgress == 2 ):
			currentDayProgress +=1
			questUpdater()
		if (currentDayProgress >= 2):
			mainMenu.openPCUi()

func rainTrigger():
	if (currentDayProgress <= 2):
		currentDayProgress +=1
		questUpdater()

func questUpdater():
	print("quest updater called")
	print("current progres ",currentDayProgress)
	if(currentDay == 1):
		print("day 1 quests")
	if(currentDay == 2):
		if mapController != null:
			print("call1")
			mapController.updateStoreInteraction(true)
		mainMenu.swapPC()
		print("day 2 quests")
	if(currentDay == 3):
		##enable storm and trigger on house
		
		print("day 3 quests")
	##check if maximum is reach
	##add new task
	##OR
	##emmit signal
	if(currentDayProgress >= dailyTaskAmmount[currentDay - 1]):
		tasksFinished = true
		emit_signal("bedUpdate",tasksFinished)
		return

