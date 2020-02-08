extends Node

onready var config = get_node('/root/config').tabuadaConfigs
onready var gameMode = get_node('/root/config').gameStatus['mode']
onready var currentLowLimit
onready var currentHighLimit

var ansewer
const DIFERENCE_LIMIT = 5
const MINUS = 0
const N_OF_POSSIBLE_ANSEWERS = 4

func _ready():
	_set_start_current_limits()

func _random_conta_with_limits(lowLimit, highLimit):
	randomize()
	var a = randi() % (highLimit - 1) + lowLimit
	var b = randi() % 8 + 2
	return [a, b, a * b]

func _update_limits():
	pass
	
func _set_start_current_limits():
	if gameMode == 'default':
		currentLowLimit = config['lowLimit']
		currentHighLimit = config['highLimit']
	else:
		currentLowLimit = config['customLowLimit']
		currentHighLimit = config['customHighLimit']

func _on_go_to_next_leve():
	pass

func random_conta():
	var conta = _random_conta_with_limits(currentLowLimit, currentHighLimit)
	ansewer = conta[2]
	return conta

func _get_random_ansewers():
	randomize()
	var listOfAsewers = []
	var diference
	var plusOrMinus
	while listOfAsewers.size() < 3:
		diference = randi() % (DIFERENCE_LIMIT - 1) + 1
		plusOrMinus = randi() % 2
		if plusOrMinus == MINUS and ansewer - diference > 3:
			listOfAsewers.append(ansewer - diference)
		else:
			listOfAsewers.append(ansewer + diference)
	listOfAsewers.append(ansewer)
	return listOfAsewers

func _randomize_positions(listOfAnsewers):
	randomize()
	var newList = [0, 0, 0, 0]
	var positions = []
	var pos
	for i in range(2):
		while true:
			pos = randi() % N_OF_POSSIBLE_ANSEWERS
			if not pos in positions: break
		positions.append(pos)
	newList[positions[0]] = listOfAnsewers[listOfAnsewers.size() - 1]
	newList[positions[1]] = listOfAnsewers[listOfAnsewers.size() - 2]
	var count = 0
	for i in range(listOfAnsewers.size()):
		if newList[i] == 0:
			newList[i] = listOfAnsewers[count]
			count += 1
	return newList

func get_possible_ansewers():
	var listOfAsewers = _get_random_ansewers()
	#return listOfAsewers
	return _randomize_positions(listOfAsewers)
	
