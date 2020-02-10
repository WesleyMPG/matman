extends KinematicBody2D

var directions = {'left': Vector2(-1, 0), 'right': Vector2(1, 0),
					'up': Vector2(0, -1), 'down': Vector2(0, 1)}
var velocity = Vector2(0, -1)

onready var sensors = {'left': $Sensors/Left, 'right': $Sensors/Right, 
				'up': $Sensors/Up, 'down': $Sensors/Down}

onready var config = get_node('/root/config').ghostConfigs
onready var SPEED = config['speed']
onready var timer = Timer.new()

const TIME_FOR_CHANGE_DIRECTION = .3
const DISCTANCE_FOR_COMPARING = 50

func _ready():
	add_child(timer)
	timer.connect("timeout", self, '_change_direction')
	_change_direction()
	

func _process(delta):
	if get_node("/root/config").gameStatus['playing']:
		_movement()
	else:
		velocity = Vector2(0, 0)
	print(_go_to_position(Vector2(position.x, 10000)))

func _change_direction():
	randomize()
	var nonWalls = _detect_walls_and_give_free_ways()
	var i = randi() % nonWalls.size()
	var direction = directions[nonWalls[i]]
	velocity = direction * SPEED
	timer.start(TIME_FOR_CHANGE_DIRECTION)

func _movement():
	#move_and_slide(velocity)
	pass

func _go_to_position(pos):
	var nonWalls = _detect_walls_and_give_free_ways()
	var bestDist = 100000000
	var dist
	var newPos
	var bestDirection
	for i in nonWalls:
		newPos = Vector2(position)
		if i == 'left':
			newPos.x -= DISCTANCE_FOR_COMPARING
			dist = _calc_distance(pos, newPos)
			if dist < bestDist:
				bestDist = dist
				bestDirection = 'left'
		elif i == 'right':
			newPos.x += DISCTANCE_FOR_COMPARING
			dist = _calc_distance(pos, newPos)
			if dist < bestDist:
				bestDist = dist
				bestDirection = 'right'
		elif i == 'up':
			newPos.y -= DISCTANCE_FOR_COMPARING
			dist = _calc_distance(pos, newPos)
			if dist < bestDist:
				bestDist = dist
				bestDirection = 'up'
		elif i == 'down':
			newPos.x -= DISCTANCE_FOR_COMPARING
			dist = _calc_distance(pos, newPos)
			if dist < bestDist:
				bestDist = dist
				bestDirection = 'down'
	return bestDirection

func _calc_distance(a, b):
	var dist = int(a.x - b.x) ^ 2 + int(a.y - b.y) ^ 2
	return dist
	

func _detect_walls_and_give_free_ways():
	var nonWalls = []
	for i in sensors.keys():
		if sensors[i].get_collider() == null:
			nonWalls.append(i)
	return nonWalls

