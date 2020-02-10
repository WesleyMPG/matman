extends Control

onready var config = get_node('/root/config')
onready var NUMBER_OF_SOCREBOARD_DIGITS = config.hudConfigs['scoreboardNumberOfDigits']
const Life = preload('res://src/scenes/player/Life.tscn')
var livesDisplayList = []

signal messageHidden

func _ready():
	update_score(0)
	update_tabuada_display(0, 0)
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
		if livesDisplayList.size() > 0:
			lastLifeAdded = livesDisplayList.back()
			instance.position.x = lastLifeAdded.position.x + 45
		livesDisplayList.append(instance)
		$LivesIndicator.add_child(instance)

func display_won_message():
	var timer = Timer.new()
	timer.one_shot = true
	add_child(timer)
	timer.start(3)
	timer.connect('timeout', self, '_hide_won_message')
	$GameWon.visible = true

func _hide_won_message():
	$GameWon.visible = false
	emit_signal('messageHidden')

func display_lost_message():
	var timer = Timer.new()
	timer.one_shot = true
	add_child(timer)
	timer.start(3)
	timer.connect('timeout', self, '_hide_lost_message')
	$GameOver.visible = true
	
func _hide_lost_message():
	$GameOver.visible = false
	get_parent().get_parent()._on_Back_pressed()

func display_pause():
	var pause = $PausedGame
	pause.visible = !pause.visible
	$AnimationPlayer.play("paused")

func update_player_lives(howManyLives):
	print(howManyLives)
	if howManyLives > livesDisplayList.size():
		howManyLives = config.playerConfigs['lives']
	for i in range(livesDisplayList.size()):
		if i < howManyLives:
			if !livesDisplayList[i].visible:
				livesDisplayList[i].visible = true
		else:
			livesDisplayList[i].visible = false

func update_tabuada_display(a, b):
	var display
	if get_tree().get_nodes_in_group('ansewers').size() > 1:
		display = str(a) + 'X' + str(b)
	else:
		display = '0X0'
	$TabuadaDisplay.text = display

func play_correct_ansewer_animation():
	$AnimationPlayer.play("right_ansewer")

func play_wrong_ansewer_animation():
	$AnimationPlayer.play("wrong_ansewer")

func get_score():
	return int($Scoreboard.text)

func reset():
	$GameOver.visible = false
	$GameWon.visible = false
	update_score(0)
