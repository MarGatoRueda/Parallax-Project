extends Control

@onready var scrollabletext = $MarginContainer/scrollabletext
@onready var button = $Button

func _ready():
	button.hide()
	scrollabletext.scroll_completed.connect(_on_scroll_completed)
	button.pressed.connect(func(): get_tree().change_scene_to_file("res://Menu/main2.tscn"))
	
func _on_scroll_completed():
	await get_tree().create_timer(3).timeout
	button.show()
