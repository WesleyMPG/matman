extends Control

signal play_button_pressed
signal options_button_pressed
signal exit_button_pressed

func _ready():
	pass

func _on_Play_pressed():
	emit_signal("play_button_pressed")
	
func _on_Exit_pressed():
	emit_signal("exit_button_pressed")

func _on_Options_pressed():
	emit_signal("options_button_pressed")
