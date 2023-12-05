extends CharacterBody3D
class_name Player

const SPEED = 3.5
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.01
	
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 9.8
var viewfinder_on = false

@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var activities_camera = $Head/Camera3D/activities_Camera
#@onready var viewfinder = $Viewfinder
@onready var count_counter = $CanvasLayer2/Counter
@onready var debug_label = $Label
@onready var ray_detector : RayCast3D = $Head/Camera3D/RayDetector
@onready var viewfinder = $CanvasLayer/Viewfinder
@onready var counter_2 = $CanvasLayer2/Counter2

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	# Assign the reference to the debug Label node.
	debug_label = $Label
	camera.current = true	
	$"../AudioStreamPlayer3D2".play()
	$"../AudioStreamPlayer3D4".play()
	$"../AudioStreamPlayer3D3".play()
	$"../AudioStreamPlayer3D".play()
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:	
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))

func on_off_VF():
	viewfinder.visible = !viewfinder.visible

func on_off_cam():
	activities_camera.visible = !activities_camera.visible

func _physics_process(delta):
	#print("Camera Position: ", global_transform.origin)
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
	var shift = Input.is_key_pressed(KEY_SHIFT)
	var running = false
	if direction and shift:
		running = true
		velocity.x = direction.x * 4*SPEED
		velocity.z = direction.z * 4*SPEED
		
	elif direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = 0.0
		velocity.z = 0.0

	if is_on_floor() and (velocity.x !=0 or velocity.z !=0):
		if $"../Timer".time_left <=0:
			$AudioStreamPlayer2D2.pitch_scale = randf_range(0.7,1.3)
			$AudioStreamPlayer2D2.play()
			if running:
				$"../Timer".start(0.25)
			else:
				$"../Timer".start(0.65)
			
	move_and_slide()
	
	var tween_vf = create_tween()
	
	# Viewfinder view
	if Input.is_action_just_pressed("right_click"):
		tween_vf.tween_property(activities_camera, "position", Vector3(0.3, -0.5, -0.6), 0.5).set_ease(Tween.EASE_IN)
		tween_vf.parallel().tween_property(activities_camera, "rotation", Vector3(0, -PI, 0), 0.5).set_ease(Tween.EASE_IN)
		tween_vf.parallel().tween_property(activities_camera, "scale", Vector3(0.4, 0.4, 0.4), 0.3).set_ease(Tween.EASE_IN)
		tween_vf.tween_property(activities_camera, "visible", false, 0.0001)
		viewfinder_on = true
		tween_vf.tween_property(viewfinder, "visible", true, 0.0001)
			
	if Input.is_action_just_pressed("left_click") and viewfinder_on:
		$CanvasLayer/AnimationPlayer.play("flash")
		$AudioStreamPlayer2D.play()
		counter_2.count -= 1
		counter_2.count_update()
			
	if not Input.is_action_pressed("right_click") and viewfinder_on:
		viewfinder_on = false
		tween_vf.tween_property(viewfinder, "visible", false, 0.5)
		tween_vf.parallel().tween_property(activities_camera, "visible", true, 0.5)
		tween_vf.tween_property(activities_camera, "position", Vector3(0.4, -0.4, -0.6), 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
		tween_vf.parallel().tween_property(activities_camera, "rotation", Vector3(-PI/180*14, -PI, -PI/180*4), 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
		tween_vf.parallel().tween_property(activities_camera, "scale", Vector3(0.125, 0.125, 0.125), 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	
	# Get the player's current position and rotation.
	var player_position = global_transform.origin
	var camera_rotation = camera.get_camera_transform().basis.get_euler()

	# Convert rotation angles to degrees for readability.
	var camera_rotation_degrees = Vector2(
		rad_to_deg(camera_rotation.x),
		rad_to_deg(camera_rotation.y),
	)

	# Create a string with the player's position and rotation.
	var debug_text = "Position: " + str(player_position) + "\nRotation: " + str(camera_rotation_degrees)

	# Update the debug Label with the player's information.
	debug_label.text = debug_text



