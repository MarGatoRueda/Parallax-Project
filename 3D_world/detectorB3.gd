extends Area3D

var player : Player = null
var raycast : RayCast3D = null
var rotation_threshold = 0.0005
@onready var local_rotation : Marker3D = $LocalRotation
@onready var target : Marker3D = $"../TargetArea3/Target"
@onready var detector = $"."
@onready var third_giggle = $"../ThirdGiggle"
@onready var thirdGirl = $"../Third"
@onready var lalala = $"../Lalala"
@onready var crash_detector = $"../CrashDetector"
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
	var distance = local_rotation.global_position.distance_to(target.global_position)
	raycast.target_position = Vector3(0, distance*1.5, 0)
	var vf = player.viewfinder
	
	if raycast.is_colliding() and vf.visible:
		# Tween for locking player's position and camera view
		var new_pos = local_rotation.global_position
		new_pos[1] = player.position.y
		if not tween:
			tween = create_tween()
			tween.tween_property(player, "position", new_pos, 0.5).set_ease(Tween.EASE_IN)
			tween.finished.connect(func (): tween = null)
			
		if Input.is_action_just_pressed("left_click"):
			tween.kill()
			tween = null
			
			thirdGirl.visible = false
			detector.monitoring = false
			third_giggle.play()
			lalala.monitoring = true
			crash_detector.monitoring = true
			truck_crash_2.monitoring = true

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
	
func get_rotation_from_direction(look_direction : Vector3) -> Basis:
	look_direction = look_direction.normalized()
	var x_axis = look_direction.cross(Vector3.UP)
	return Basis(x_axis, Vector3.UP, -look_direction)	
	
