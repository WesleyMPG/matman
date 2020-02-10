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
		restart()
		get_node('/root/config').gameStatus['started'] = false
	$Hud.update_player_lives(lives)

func _end_game():
	get_node('/root/config').gameStatus['playing'] = false
	$Hud.display_lost_message()

func _game_won():
	get_node('/root/config').gameStatus['playing'] = false
	$Hud.display_won_message()

func ghosts_to_start():
	var ghosts = $Ghosts.get_children()
	var sps = $Spawns.get_children()
	for i in ghosts.size():
		ghosts[i].position = $Spawns/Ghosts.position

func restart():
	$Player.restart()
	get_tree().call_group('enemys', 'change_alive')
	$Player.position = $Spawns/Player.position
	ghosts_to_start()
	var timer = Timer.new()
	timer.one_shot = true
	add_child(timer)
	timer.connect('timeout', self, 'start')
	timer.start(3)
	$Hud/Ready.visible = true
	

func reset():
	$Map.reset()
	restart()
	
func start():
	$Hud/Ready.visible = false
	get_node('/root/config').gameStatus['playing'] = true
	get_node('/root/config').gameStatus['started'] = true
	get_tree().call_group('enemys', 'change_alive')
	$Player.alive = true
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

func get_nav2d():
	return $Map.get_nav2d()
