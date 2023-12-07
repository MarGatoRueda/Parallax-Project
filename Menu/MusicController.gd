extends Node2D

var lacrimosa = load("res://Audio/Lacrimosa - W.A. Mozart (Copyright Free Audio) - Rivulet.mp3")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func play_music():
	$Music.stream = lacrimosa
	$Music.play(12.0)
