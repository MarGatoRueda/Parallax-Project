extends Area3D

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)
	body_entered.connect(_on_Area3D_body_entered)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_Area3D_body_entered(body):
	if body is Player:
		var audio = $TruckCrash
		if audio and not audio.playing:
			audio.play()
			await get_tree().create_timer(2.7).timeout
			$AnimationPlayer.play("flash")
			await get_tree().create_timer(1.3).timeout
			print("Change")
			#get_tree().change_scene_to_file("res://Levels/level_2.tscn")
