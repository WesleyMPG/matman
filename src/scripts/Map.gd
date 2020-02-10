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
	var labels = [$Ansewers/AswBp, $Ansewers/AswBp2, $Ansewers/AswBp3,
					$Ansewers/AswBp4,]
	var pills = [$Pills/BigPill, $Pills/BigPill2, $Pills/BigPill3,
				$Pills/BigPill4,]
	var ansewers = get_tree().get_nodes_in_group('ansewers')
	for i in range(labels.size()):
		if pills[i] in ansewers:
			labels[i].text = str(pills[i].get_ansewer())
		else:
			labels[i].text = '00'
	if pills.size() == 1:
		for i in range(labels.size()):
			labels[i].text = '00'

func update_ansewers(ansewers):
	var pills = get_tree().get_nodes_in_group('ansewers')
	if (pills.size() > 1):
		for i in range(ansewers.size()):
			pills[i].update_ansewer(ansewers[i])
			_labels_asw()
	elif pills.size() == 1:
		pills[0].update_ansewer(0)
		_labels_asw()

func get_nav2d() -> Navigation2D:
	var nav : Navigation2D = $Maps/Navigation2D
	return nav
