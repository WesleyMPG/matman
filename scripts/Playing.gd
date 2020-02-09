extends Node2D

func _ready():
	reset()
	
func _process(delta):
	pass

func _on_Player_justAteAPill(pill):
	$Hud.update_score(pill.POINTS)
	if get_tree().get_nodes_in_group('eatbles').size() == 0:
		_game_won()

func _on_Player_gotHit(lives):
	if lives == 0:
		_end_game()
	else:
		$Player.restart()
		$Player.position = $Spaws/Player.position
		$Hud.update_player_lives(lives)

func _end_game():
	get_node('/root/config').gameStatus['playing'] = false

func _game_won():
	get_node('/root/config').gameStatus['playing'] = false
	$Hud.display_won_message()

func reset():
	$Player.reset()
	$Player.position = $Spawns/Player.position
	$Map.reset()
	var timer = Timer.new()
	timer.one_shot = true
	add_child(timer)
	timer.start(3)
	$Hud/Ready.visible = true
	timer.connect('timeout', self, 'start')
	
func start():
	$Hud/Ready.visible = false
	get_node('/root/config').gameStatus['playing'] = true
	get_node('/root/config').gameStatus['started'] = true
	_update_tabuada()

func _on_Hud_messageHidden():
	reset()
	
func _update_tabuada():
	var ansewers
	if get_tree().get_nodes_in_group('ansewers').size() > 1:
		var conta = $Tabuada.random_conta()
		ansewers = $Tabuada.get_possible_ansewers()
		$Hud.update_tabuada_display(conta[0], conta[1])
	else:
		ansewers = []
		$Hud.update_tabuada_display(0, 0)
	$Map.update_ansewers(ansewers)

func _on_Player_ansewered(ansewer):
	var score = $Hud.get_score()
	if ansewer == $Tabuada.ansewer:
		$Hud.play_correct_ansewer_animation()
		$Hud.update_score(score / 2)
	elif ansewer == 0:
		pass
	else:
		$Hud.play_wrong_ansewer_animation()
		$Hud.update_score(-score / 5)
	_update_tabuada()
