extends Area3D

@onready var collision_shape_3d = $CollisionShape3D
@onready var head = $"../Player/Head"
var inside = false
@onready var camera = $"../Player/Head/Camera3D"



# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var camera_rotation = camera.get_camera_transform().basis.get_euler()

	# Convert rotation angles to degrees for readability.
	var camera_rotation_degrees = Vector3(
		rad_to_deg(camera_rotation.x),
		rad_to_deg(camera_rotation.y),
		rad_to_deg(camera_rotation.z)
	)
	
	if inside == true:
		var rot_x = snapped(camera_rotation_degrees[0], 0.01)
		var rot_y = snapped(camera_rotation_degrees[1], 0.01)
		var within = ((-4.58 - 1 < rot_x) and (rot_x < -4.58 + 1) and 
		(rot_y < 0.39 + 1) and (0.39 - 1 < rot_y))
		if within == true:
			print("YESS")
			pass
		if within == false:
			print("NOO")
			pass
			
		

func _on_body_entered(body: Node):
	inside = true
	print("AAA")
	
func _on_body_exited(body: Node):
	inside = false
	print("BBB")
