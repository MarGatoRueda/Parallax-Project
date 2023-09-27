extends MarginContainer


@onready var retry = %Retry
@onready var menu = %Menu
@onready var exit = %Exit
@onready var count_counter = $Counter
@export var main_menu: PackedScene

func _ready() -> void:
	retry.pressed.connect(_on_retry_pressed_Dead)
	menu.pressed.connect(_on_menu_pressed)
	exit.pressed.connect(_on_exit_pressed)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	
func _on_retry_pressed_Dead():
	get_tree().change_scene_to_file("res://3D_world/main.tscn")
	
	
	
func _on_menu_pressed():
	if not main_menu:
		return
	get_tree().change_scene_to_packed(main_menu)
	get_tree().paused = false
	
	
	
func _on_exit_pressed():
	get_tree().quit()
	
