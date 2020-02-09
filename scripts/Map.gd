extends Node2D

func _ready():
	pass

func _on_LeftTp_body_entered(body):
	body.position.x += 500   

func _on_RightTp_body_entered(body):
	body.position.x -= 500

func reset():
	get_tree().call_group('eaten', 'reset')
	
func _labels_asw():
	$Ansewers/AswBp.text = str($Pills/BigPill.get_ansewer())
	$Ansewers/AswBp2.text = str($Pills/BigPill2.get_ansewer())
	$Ansewers/AswBp3.text = str($Pills/BigPill3.get_ansewer())
	$Ansewers/AswBp4.text = str($Pills/BigPill4.get_ansewer())

func update_ansewers(ansewers):
	var pills = get_tree().get_nodes_in_group('ansewers')
	if (pills.size() > 1):
		for i in range(ansewers.size()):
			pills[i].update_ansewer(ansewers[i])
			_labels_asw()
	elif pills.size() == 1:
		pills[0].update_ansewer(0)
	#_labels_asw()
