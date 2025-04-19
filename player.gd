extends Area2D

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.


func _ready():
	screen_size = get_viewport_rect().size
	hide()
	

func _process(delta):
	var velocity: Vector2 = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1


	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		get_node("AnimatedSprite2D").play()
	else:
		get_node("AnimatedSprite2D").stop()

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

	if velocity.x != 0:
		get_node("AnimatedSprite2D").animation = "walk"
		get_node("AnimatedSprite2D").flip_v = false
		get_node("AnimatedSprite2D").flip_h = velocity.x < 0
	if velocity.y != 0:
		get_node("AnimatedSprite2D").animation = "up"
		get_node("AnimatedSprite2D").flip_h = false
		get_node("AnimatedSprite2D").flip_v = velocity.y > 0


	if velocity.x < 0:
		get_node("AnimatedSprite2D").flip_h = true
	else:
		get_node("AnimatedSprite2D").flip_h = false
