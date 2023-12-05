extends Area3D

var player : Player = null
@onready var local_rotation : Marker3D = $LocalRotation
@onready var camera_3d = $LocalRotation/Camera3D
@onready var truck_crash = $"../TruckCrash"
@onready var truck_crash_2 = $"../TruckCrash2"

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
	
	# Tween for locking player's position and camera view
	var new_pos = local_rotation.global_position
	new_pos[1] = player.position.y
	tween = create_tween()
	tween.tween_property(player, "position", new_pos, 0.5).set_ease(Tween.EASE_IN)
	tween.finished.connect(func (): tween = null)
	await get_tree().create_timer(0.7).timeout
	#tween.kill()
	camera_3d.current = true
	player.set_physics_process(false)
	player.visible = false
	truck_crash.play("Tragedy")
	

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
	
