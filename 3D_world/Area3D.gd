extends Area3D

@onready var collision_shape_3d = $CollisionShape3D
@onready var player = $"../Player"
@onready var head = $"../Player/Head"
@onready var camera = $"../Player/Head/Camera3D"
@onready var viewfinder = $"../Player/Head/Camera3D/Viewfinder"
@onready var flower_marker = $"../flower_purpleA/flowerMarker"
var inside = false

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
		var within = ((-4.58 - 3 < rot_x) and (rot_x < -4.58 + 3) and 
		(rot_y < 0.39 + 3) and (0.39 - 3 < rot_y))
		print(viewfinder.visible)
		if within == true:
			new_posPlayer(player, collision_shape_3d, camera)
			teleportPlayer(player, flower_marker)
			within == false
			print("YESS")
		if within == false:
			print("NOO")
			pass
			
		

func _on_body_entered(body: Node):
	inside = true
	print("AAA")
	
func _on_body_exited(body: Node):
	inside = false
	print("BBB")
	
func new_posPlayer(player: CharacterBody3D, cs3d: CollisionShape3D, cam: Camera3D):
	var new_pos = cs3d.global_position
	new_pos[1] = player.position.y
	var new_view = Vector3(deg_to_rad(-4.58), deg_to_rad(0.39), deg_to_rad(0))
	var tween = create_tween()
	tween.tween_property(player, "position", new_pos, 0.5).set_ease(Tween.EASE_IN)
	tween.tween_property(cam, "rotation", new_view, 0.5).set_ease(Tween.EASE_IN)
	
func teleportPlayer(player: CharacterBody3D, marker: Marker3D):
	player.global_position = flower_marker.global_position	
