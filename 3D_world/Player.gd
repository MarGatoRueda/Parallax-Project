extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.01

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 9.8

@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var activities_camera = $Head/Camera3D/activities_Camera
@onready var viewfinder = $Head/Camera3D/Viewfinder
@onready var count_counter = $Counter





func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:	
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(60))

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = 0.0
		velocity.z = 0.0

	move_and_slide()
	
	var tween_vf = create_tween()
	# Viewfinder view
	if Input.is_action_pressed("right_click"):
		tween_vf.tween_property(activities_camera, "position", Vector3(0.3, -0.5, -0.6), 0.5).set_ease(Tween.EASE_IN)
		tween_vf.parallel().tween_property(activities_camera, "rotation", Vector3(0, -PI, 0), 0.5).set_ease(Tween.EASE_IN)
		tween_vf.parallel().tween_property(activities_camera, "scale", Vector3(0.4, 0.4, 0.4), 0.3).set_ease(Tween.EASE_IN)
		tween_vf.tween_property(activities_camera, "visible", false, 0.0001)
		tween_vf.tween_property(viewfinder, "visible", true, 0.0001)
		if Input.is_action_just_pressed("left_click"):
			count_counter.count -= 1
			count_counter.count_update()
			
			
	if Input.is_action_just_released("right_click"):
		tween_vf.tween_property(viewfinder, "visible", false, 0.5)
		tween_vf.parallel().tween_property(activities_camera, "visible", true, 0.5)
		tween_vf.tween_property(activities_camera, "position", Vector3(0.4, -0.4, -0.6), 0.5).set_ease(Tween.EASE_IN)
		tween_vf.parallel().tween_property(activities_camera, "rotation", Vector3(-PI/180*14, -PI, -PI/180*4), 0.5).set_ease(Tween.EASE_IN)
		tween_vf.parallel().tween_property(activities_camera, "scale", Vector3(0.125, 0.125, 0.125), 0.5).set_ease(Tween.EASE_IN)





