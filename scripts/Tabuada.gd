extends Node

func _ready():
	pass

func random_conta(low_limit, high_limit):
	var a = randi() % high_limit + low_limit
	var b = randi() % high_limit + low_limit
	return [a, b, a * b]
	 
