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

func _randomise_positions(listOfAnsewers):
	randomize()
	print(listOfAnsewers)
	var newList = []
	var pos
	while newList.size() < 4:
		pos = randi() % N_OF_POSSIBLE_ANSEWERS
		if not listOfAnsewers[pos] in newList:
			newList.append(listOfAnsewers[pos])

func get_possible_ansewers():
	var listOfAsewers = _get_random_ansewers()
	return _randomise_positions(listOfAsewers)
	
