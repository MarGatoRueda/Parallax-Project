extends Area3D

var player : Player = null
@onready var local_rotation : Marker3D = $LocalRotation
@onready var camera_3d = $LocalRotation/Camera3D
@onready var the_end = $"../TheEnd"

var tween;

@export var lerp_speed = 3.0
@export var offset = Vector3.ZERO

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
	var vf = player.viewfinder
	
	player.set_physics_process(false)
	player.visible = false
	camera_3d.current = true
	

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
	
