extends CharacterBody2D


const SPEED = 300.0

var gravity = 0


func _physics_process(delta):
	
	var directionh = Input.get_axis("move_left", "move_right")
	if directionh:
		velocity.x = directionh * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var directionv = Input.get_axis("move_up", "move_down")
	if directionv:
		velocity.y = directionv * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
