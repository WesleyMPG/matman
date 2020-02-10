extends KinematicBody2D

onready var config = get_node('/root/config').ghostConfigs
onready var SPEED = config['speed']
onready var path
onready var timer = Timer.new()

var alive = true

func _ready():
	add_child(timer)
	timer.start(1)
	timer.connect("timeout", self, 'get_new_path')

func _process(delta):
	if  get_node('/root/config').gameStatus['playing'] and alive:
		var moveDistance = SPEED * delta
		_move_along_path(moveDistance)

func change_alive():
	alive = !alive
	
func _move_along_path(distance):
	var startingPoint = position
	for i in range(path.size()):
		var distanceToNext = startingPoint.distance_to(path[0])
		if distance <= distanceToNext and distance >= 0:
			position = startingPoint.linear_interpolate(path[0], distance / distanceToNext)
			break
		elif distance < 0:
			position = path[0]
		distance -= distanceToNext
		startingPoint = path[0]
		path.remove(0)
	
func get_new_path():
	var player = get_tree().get_nodes_in_group('players')[0]
	var nav : Navigation2D = get_parent().get_parent().get_nav2d()
	var newPath : = nav.get_simple_path(position, player.position)
	add_child(Line2D.new())
	path = newPath
	timer.start(.5)
