extends prop

func endTrigger():
	var owner = get_owner()
	owner.endScene()
	disableInteraction()
	print("end")
