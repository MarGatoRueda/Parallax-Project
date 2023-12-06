extends Control


@onready var retry = %Retry
@onready var menu = %Menu
@onready var exit = %Exit
@onready var count_counter = $Counter
@export var main2: PackedScene

func _ready() -> void:
	retry.pressed.connect(_on_retry_pressed_Dead)
	menu.pressed.connect(_on_menu_pressed)
	exit.pressed.connect(_on_exit_pressed)
	
	
	
func _on_retry_pressed_Dead():
	visible = !visible
	get_tree().paused = visible
	get_tree().reload_current_scene()
	
	
	
func _on_menu_pressed():
	if not main2:
		return
	get_tree().change_scene_to_packed(main2)
	get_tree().paused = false
	
	
	
func _on_exit_pressed():
	get_tree().quit()
	
