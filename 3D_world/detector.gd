extends Area3D

var player : Player = null
var rotation_threshold = 0.0005
@onready var local_rotation = $LocalRotation

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)
	body_entered.connect(_on_body_entered)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

	
func _physics_process(delta):
	if not is_instance_valid(player):
		return
	var camera_rotation = player.camera.quaternion
	var diff = local_rotation.quaternion.dot(camera_rotation)
	print(abs(1-diff))

func _on_body_entered(body: Node3D):
	if not body is Player:
		return
	player = body
	set_physics_process(true)

func _on_body_exit(body: Node3D):
	if not body is Player:
		return
	player = null
	set_physics_process(false)	

