extends Control

var count = 10
@onready var count_label = $count
@export var dead: PackedScene

func _ready() -> void:
	count_update()

func count_update():
	count_label.text = str(count)



		
