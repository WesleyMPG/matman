extends KinematicBody2D

onready var config = get_node('/root/config').playerConfigs
onready var gameStatus = get_node('/root/config').gameStatus

var alive = true
onready var SPEED = config['speed']
onready var lives = config['lives'] 
var velocity = Vector2(0,0)

signal justAteAPill
signal ansewered
signal gotHit

func _ready():
	restart()	

func _process(delta):
	if get_node('/root/config').gameStatus['playing'] and alive:
		_movement(delta)
		
func _movement(delta):
	var realWalkDistance = SPEED
	if Input.is_action_pressed("ui_left"):
		velocity = Vector2(-realWalkDistance, 0)
		rotation_degrees = -90
		$Sprite.play('walk')
	elif Input.is_action_pressed("ui_right"):
		velocity = Vector2(realWalkDistance, 0)
		rotation_degrees = 90
		$Sprite.play('walk')
	elif Input.is_action_pressed("ui_up"):
		velocity = Vector2(0, -realWalkDistance)
		rotation_degrees = 0
		$Sprite.play('walk')
	elif Input.is_action_pressed("ui_down"):
		velocity = Vector2(0, realWalkDistance)
		rotation_degrees = 180
		$Sprite.play('walk')
	move_and_slide(velocity)

func take_damage():
	if alive:
		alive = false
		$Sprite.play('death')
		visible = false
		lives -= 1
		emit_signal("gotHit", lives)

func restart():
	alive = true
	$Sprite.play('idle')
	visible = true
	rotation_degrees = 90

func reset():
	restart()
	lives = config['lives']

func _on_Mouth_area_entered(area):
	if area.is_in_group('eatbles'):
		if area.is_in_group('ansewers'):
			area.was_eaten()
			emit_signal("ansewered", area.get_ansewer())
		else:
			area.was_eaten()
			emit_signal("justAteAPill", area)
		
