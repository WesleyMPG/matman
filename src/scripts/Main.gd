extends Node2D

var playingScene

func _ready():
	playingScene = preload("res://src/scenes/Playing.tscn")


func _on_Menu_play_button_pressed():
	var menu = $Menu
	var topButtons = $TopButtons
	menu.queue_free()
	remove_child(menu)
	add_child(playingScene.instance())
	remove_child(topButtons)
	add_child(topButtons)
	_enable_disable_buttons()

func _on_Menu_exit_button_pressed():
	get_tree().quit()
	
func _on_Pause_pressed():
	if get_node('/root/config').gameStatus['started']:
		var aux = get_node('/root/config').gameStatus['playing']
		get_node('/root/config').gameStatus['playing'] = !aux
		$Playing/Hud.display_pause()

func _enable_disable_buttons():
	var back = $TopButtons/Back
	var pause = $TopButtons/Pause
	var aux = back.visible
	back.visible = !aux
	back.disabled = aux
	pause.visible = !aux
	pause.disabled = aux


func _on_Back_pressed():
	_enable_disable_buttons()
	var playing = $Playing
	var menu = load('res://scenes/menu_and_display/Menu.tscn')
	playing.queue_free()
	remove_child(playing)
	var inst = menu.instance()
	add_child(inst)
	inst.connect('play_button_pressed', self, '_on_Menu_play_button_pressed')
	inst.connect('exit_button_pressed', self, '_on_Menu_exit_button_pressed')
	get_node('/root/config').gameStatus['started'] = false
	get_node('/root/config').gameStatus['playing'] = false

func _on_Pause_button_up():
	$TopButtons/Pause/branco.visible = false
	$TopButtons/Pause/preto.visible = true

func _on_Pause_button_down():
	$TopButtons/Pause/branco.visible = true
	$TopButtons/Pause/preto.visible = false
