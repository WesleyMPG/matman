extends Area2D

onready var config = get_node('/root/config').pillConfigs

onready var POINTS = config['points']

func _ready():
	pass

func was_eaten():
	visible = false
	$CollisionShape2D.disabled = true
	remove_from_group('eatbles')
	add_to_group('eaten')
	
func reset():
	visible = true
	$CollisionShape2D.disabled = false
	remove_from_group('eaten')
	add_to_group('eatbles')
