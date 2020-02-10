extends Node

onready var config = get_node('/root/config').tabuadaConfigs
onready var gameMode = get_node('/root/config').gameStatus['mode']
onready var currentLowLimit
onready var currentHighLimit

var ansewer
var ansewersRequired
const DIFERENCE_LIMIT = 5
const MINUS = 0

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
	var listOfAnsewers = [ansewer]
	var diference
	var plusOrMinus
	var temp
	while listOfAnsewers.size() < ansewersRequired:
		diference = randi() % (DIFERENCE_LIMIT - 1) + 1
		plusOrMinus = randi() % 2
		if plusOrMinus == MINUS and ansewer - diference > 3:
			temp = ansewer - diference
		else:
			temp = ansewer + diference
		if not temp in listOfAnsewers:
			listOfAnsewers.append(temp)
	return listOfAnsewers

func _fill_list_with_i_positions(i):
	var newList = []
	for k in range(i):
		newList.append(0)
	return newList
		
func _get_random_positions():
	randomize()
	var positions = []
	var pos
	for i in range(ansewersRequired / 2):
		while true:
			pos = randi() % ansewersRequired
			if not pos in positions: break
		positions.append(pos)
	return positions

func _randomize_positions(listOfAnsewers):
	var newList = _fill_list_with_i_positions(ansewersRequired)
	var positions = _get_random_positions()
	var count
	for i in range(ansewersRequired / 2):  # the minimum of ansewers required is 2
		newList[positions[i]] = listOfAnsewers[i]
		count = i
	for i in range(listOfAnsewers.size()):
		if newList[i] == 0:
			count += 1
			newList[i] = listOfAnsewers[count]
	return newList

func get_possible_ansewers():
	ansewersRequired = get_tree().get_nodes_in_group('ansewers').size()
	var listOfAsewers = _get_random_ansewers()
	return _randomize_positions(listOfAsewers)
	
