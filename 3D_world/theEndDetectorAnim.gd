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
			MusicController.play_music()
			$"../Mila'sFather".visible = true
			$"../TheEnd".play("TheEnd")
			await get_tree().create_timer(14.5).timeout
			get_tree().change_scene_to_file("res://Menu/credits_final.tscn")
