extends Control

onready var config = get_node('/root/config')
onready var NUMBER_OF_SOCREBOARD_DIGITS = config.hudConfigs['scoreboardNumberOfDigits']
const Life = preload('res://scenes/player/Life.tscn')
var livesDisplay = []

func _ready():
	$Scoreboard.text = _complete_score_digits(0)
	_display_player_lives()

func _check_number_of_digits(value):
	var cont = 1;
	while value / 10 != 0:
		cont += 1;
		value /= 10
	return cont

func _fill_digits_left(digitsLeft):
	var score = ''
	for i in range(digitsLeft):
		score += '0'
	return score

func _complete_score_digits(value):
	var nDigits = _check_number_of_digits(value)
	var digitsLeft = NUMBER_OF_SOCREBOARD_DIGITS - nDigits
	return _fill_digits_left(digitsLeft) + str(value)

func update_score(value):
	var score = int($Scoreboard.text)
	score += value
	var newScore = _complete_score_digits(score)
	$Scoreboard.text = newScore

func _display_player_lives():
	var instance
	var lastLifeAdded
	for i in config.playerConfigs['lives']:
		instance = Life.instance()

#		lastLifeAdded = livesDisplay.back()
#		if lastLifeAdded != null:
#			instance.position.x = lastLifeAdded.position.x + 45
#		livesDisplay.append(instance)
		$LivesIndicator.add_child(instance)
		$LivesIndicator.add_spacer(true)
		
func update_player_lives(howManyLives):
	pass
