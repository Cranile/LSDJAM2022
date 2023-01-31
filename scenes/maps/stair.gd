extends prop

func climbLadder():
	##this method is incorrect
	##should pass parameter isntead of hardcoded name
	var newPos

	if(propName == "stair spawn"):
		newPos = get_owner().returnLadderPos("spawn")
	if(propName == "stair house"):
		newPos = get_owner().returnLadderPos("house")
	main.teleportPlayer(newPos)
