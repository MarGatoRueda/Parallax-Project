extends Area3D

var player : Player = null
var raycast : RayCast3D = null
var rotation_threshold = 0.0005
@onready var local_rotation : Marker3D = $LocalRotation
@onready var target : Marker3D = $"../TargetArea/Target"

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exit)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

	
func _physics_process(delta):
	if not is_instance_valid(player):
		return
	var distance = local_rotation.global_position.distance_to(target.global_position)
	raycast.target_position = Vector3(0, distance*1.2, 0)
	
	if raycast.is_colliding():
		# Teleport
		player.global_position = target.global_position
	#var camera_rotation = player.camera.quaternion
	#var diff = local_rotation.quaternion.dot(camera_rotation)
	#print(abs(1-diff))

func _on_body_entered(body: Node3D):
	if not body is Player:
		return
	player = body
	raycast = player.ray_detector
	set_physics_process(true)

func _on_body_exit(body: Node3D):
	if not body is Player:
		return
	raycast.target_position = Vector3(0, 1, 0)
	raycast = null
	player = null
	set_physics_process(false)	
	
