extends MarginContainer

var count = 10
@onready var count_label = $HBoxContainer/count
@export var dead: PackedScene
func _ready() -> void:
	count_update()

func count_update():
	count_label.text = str(count)
	end()

func end():
	if count == 0:
		get_tree().change_scene_to_packed(dead)
