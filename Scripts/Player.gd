extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
		if(velocity.y > 0):
			animated_sprite.animation = "fall"
		else:
			animated_sprite.animation = "jump"
	else:
		if(velocity.x == 0):
			animated_sprite.animation = "idle"
		else:
			animated_sprite.animation = "run"
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		
		if(velocity.x < 0):
			animated_sprite.flip_h = true
		elif(velocity.x > 0):
			animated_sprite.flip_h = false
			
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()
