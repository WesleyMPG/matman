extends KinematicBody2D

onready var sensors = {'left': $Sensors/Left, 'right': $Sensors/Right, 
				'up': $Sensors/Up, 'down': $Sensors/Down}
var directions = {'left': Vector2(-1, 0), 'right': Vector2(1, 0),
					'up': Vector2(0, -1), 'down': Vector2(0, 1)}

onready var config = get_node('/root/config').ghostConfigs

onready var SPEED = config['speed']
var velocity = Vector2(0, 0)

func _ready():
	print(sensors)

func _process(delta):
	if get_node("/root/config").gameStatus['playing']:
		_movement()
	else:
		velocity = Vector2(0, 0)

func _movement():
	randomize()
	var nonWalls = _detect_walls_and_give_free_ways()
	var i = randi() % nonWalls.size()
	var direction = directions[nonWalls[i]]
	velocity = direction * SPEED
	move_and_slide(velocity)

func _detect_walls_and_give_free_ways():
	var nonWalls = []
	for i in sensors.keys():
		if sensors[i].get_collider() == null:
			nonWalls.append(i)
	return nonWalls

