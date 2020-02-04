extends KinematicBody2D

onready var config = get_node('/root/config').playerConfigs

var alive = true
onready var SPEED = config['speed']
onready var lives = config['lives'] 
var velocity

signal justAteAPill
signal ansewered

func _ready():
	restart()	

func _process(delta):
	if alive:
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
	else:
		velocity = Vector2(0, 0)
	move_and_slide(velocity)

func take_damage():
	alive = false
	$Sprite.play('death')
	visible = false

func restart():
	alive = true
	$Sprite.play('idle')
	visible = true
	rotation_degrees = 90

func _on_Mouth_area_entered(area):
	if area.is_in_group('eatbles'):
		area.was_eaten()
		emit_signal("justAteAPill", area)
