extends Control

@onready var start = %Start
@onready var exit = %Exit
@onready var credits = $Credits


func _ready() -> void:
	start.pressed.connect(_on_start_pressed)
	exit.pressed.connect(_on_exit_pressed)
	credits.pressed.connect(_on_credits_pressed)

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Levels/level_0.tscn")


func _on_credits_pressed():
	get_tree().change_scene_to_file("res://Menu/credits_final.tscn")

func _on_exit_pressed():
	get_tree().quit()
