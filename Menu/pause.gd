extends MarginContainer

@onready var pause = $"."
@onready var resume = %Resume
@onready var retry = %Retry
@onready var menu = %Menu
@onready var exit = %Exit


@export var main_menu: PackedScene

func _ready() -> void:
	resume.pressed.connect(_on_resume_pressed)
	retry.pressed.connect(_on_retry_pressed)
	menu.pressed.connect(_on_menu_pressed)
	exit.pressed.connect(_on_exit_pressed)
	
	hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		visible = !visible
		get_tree().paused = visible

func _on_resume_pressed():
	hide()
	
	
	
func _on_retry_pressed():
	get_tree().reload_current_scene()
	
	
	
func _on_menu_pressed():
	if not main_menu:
		return
	get_tree().change_scene_to_packed(main_menu)
	
	
	
func _on_exit_pressed():
	get_tree().quit()
	

