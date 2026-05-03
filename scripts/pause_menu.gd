extends Control

@export var resumeButton: Button
@export var mainMenuButton: Button

func _ready() -> void:
	resumeButton.pressed.connect(_on_resume_button_pressed)
	mainMenuButton.pressed.connect(_on_main_menu_button_pressed)
	visible = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused:
			get_tree().paused = false
			visible = false
		else:
			get_tree().paused = true
			visible = true

func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	visible = false

func _on_main_menu_button_pressed() -> void:
	pass
