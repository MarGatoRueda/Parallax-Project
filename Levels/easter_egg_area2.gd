extends Area3D

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)
	body_entered.connect(_on_Area3D2_body_entered)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

var played = false
func _on_Area3D2_body_entered(body):
	if body is Player:
		var audio = $parable
		if audio and not audio.playing and not played:
			played = true
			audio.play()
