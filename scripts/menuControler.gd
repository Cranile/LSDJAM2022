extends CanvasLayer

onready var mainMenu = $mainMenu
onready var mainSection = $mainMenu/mainSection
onready var optionSection = $mainMenu/optionSection
onready var creditSection = $mainMenu/creditSection
onready var scrollContainer = $mainMenu/optionSection/ScrollContainer

onready var mouseController = $mainMenu/optionSection/ScrollContainer/VBoxContainer/mouseSlider
onready var crossHair = get_node("crossHair")

onready var pcui = $computerScreen
var isPCON = false
var mainScript;

onready var eyelidTop = $eyes/top
onready var eyelidBottom = $eyes/bottom
var animationPlaySpeed = 1
signal lidState(state)

var currentDialogue
var debugLabel 
func _ready():
	mainMenu.hide()
	mainSection.hide()
	optionSection.hide()
	creditSection.hide()
	pcui.hide()
	mainScript = get_owner()
	changeCrossHair(false)
	if mainScript.currentDay == 1 :
		$computerScreen/day1.show()
		$computerScreen/day2.hide()
	
	debugLabel = $crossHair/debugName
	if mainScript.debugMode:
		debugLabel.show()
	else :
		debugLabel.hide()
	
##toggle the entire menu window
func menuToggle():
	if (mainMenu.visible):
		mainMenu.hide()
		mainToggle(true)
		optionToggle(false)
		creditToggle(false)
		return;
	
	mainMenu.show()
	mainToggle(false)
	optionToggle(true)
	creditToggle(true)

## when this is called the main section will close and the options section will open
func openOptionSection():
	mainToggle(true)
	optionToggle(false)

## when this is called the main section will open and the options section will close
func closeOptionSection():
	optionToggle(true)
	mainToggle(false)

## when this is called the main section will close and the credits section will open
func openCreditSection():
	mainToggle(true)
	creditToggle(false)

## when this is called the main section will open and the credits section will close
func closeCreditSection():
	creditToggle(true)
	mainToggle(false)

## enable or disable the main section of the menu (this contains the buttons for the other sections)
func mainToggle(hide):
	if (isPCON):
		closePCui()
	if (hide):
		mainSection.hide()
		return;
	mainSection.show()

## enable or disable the configuration and options section of the menu
func optionToggle(hide):
	if (hide):
		optionSection.hide()
		return;
	optionSection.show()
	updateScrollValue()

func creditToggle(hide):
	if (hide):
		creditSection.hide()
		return;
	creditSection.show()


func _on_buttonOptions_pressed():
	openOptionSection()
	pass # Replace with function body.

func _on_buttonCredits_pressed():
	openCreditSection()

func _on_backFromOption_pressed():
	closeOptionSection()

func _on_backFromCredits_pressed():
	closeCreditSection();

func _on_buttonExit_pressed():
	get_tree().quit();

func updateScrollValue():
	mouseController.setCurrentValue( mainScript.getSensitivity() )

func changeCrossHair(type):
	crossHair.changeCrosshair(type)

func newDialogue(timelineName):
	print("dialogue")
	currentDialogue = Dialogic.start(timelineName)
	currentDialogue.connect("timeline_end", self, "endConversation")
	add_child(currentDialogue)

func endConversation(_timeline_end):
	mainScript.handleUI()

func openPCUi():
	mainScript.handleUI()
	pcui.show()
	isPCON = true
func closePCui():
	mainScript.handleUI()
	pcui.hide()
	isPCON = false

func eyelidsUpdate(state):
	emit_signal("lidState",false)
	if state :
		##anim start
		animationPlaySpeed = 1
		$eyes/AnimationPlayer.set_speed_scale(animationPlaySpeed)
		$eyes/AnimationPlayer.play("blink")
	else :
		animationPlaySpeed = 5
		$eyes/AnimationPlayer.set_speed_scale(animationPlaySpeed)
		$eyes/AnimationPlayer.play_backwards("blink")

func playBackwards():
	print("asni")
	animationPlaySpeed = 5
	$eyes/AnimationPlayer.set_speed_scale(animationPlaySpeed)
	$eyes/AnimationPlayer.play_backwards("blink")

func _on_AnimationPlayer_animation_finished(anim_name):
	##anim end
	if (animationPlaySpeed == 1):
		emit_signal("lidState",true)
	pass # Replace with function body.

func _on_exitPC_pressed():
	closePCui()
	pass # Replace with function body.

func swapPC():
		$computerScreen/day1.hide()
		$computerScreen/day2.show()
func debugLabelUpdate(name):
	debugLabel.text = name
