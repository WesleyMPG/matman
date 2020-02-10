extends "res://src/scripts/Pill.gd"

func _ready():
	pass

func was_eaten():
	.was_eaten()  # call pill's was_eaten()
	remove_from_group('ansewers')
	print(get_tree().get_nodes_in_group('ansewers'))

func reset():
	.reset()
	add_to_group('ansewers')

func get_ansewer():
	return int($Ansewer.text)

func update_ansewer(ansewer):
	$Ansewer.text = str(ansewer)
