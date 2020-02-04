extends Node2D

onready var playing = true

func _ready():
	pass

func _on_Player_justAteAPill(pill):
	$Hud.update_score(pill.POINTS)
