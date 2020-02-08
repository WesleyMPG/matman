extends Node2D

func _ready():
	pass

func _on_LeftTp_body_entered(body):
	body.position.x += 500   

func _on_RightTp_body_entered(body):
	body.position.x -= 500

func reset():
	get_tree().call_group('eaten', 'reset')
