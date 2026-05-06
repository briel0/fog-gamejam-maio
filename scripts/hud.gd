extends Control


@export var progressBar: ProgressBar
@export var lifeBar: HBoxContainer
@export var health3Icon: Texture2D
@export var health2Icon: Texture2D
@export var health1Icon: Texture2D
@export var deadIcon: Texture2D
@onready var healthIcon = $HealthIcon

func _ready() -> void:
	set_progress(0)

func _process(delta: float) -> void:
	var progress = progressBar.value
	progress += delta * 10
	set_progress(progress)

func update_health_icon(currentHealth : int):
	if currentHealth==3:
		healthIcon.texture = health3Icon
	elif currentHealth==2:
		healthIcon.texture = health2Icon
	elif currentHealth==1:
		healthIcon.texture = health1Icon
	else:
		healthIcon.texture = deadIcon

func set_progress(value: float) -> void:
	progressBar.value = value
	if value >= progressBar.max_value:
		on_progress_complete()
		set_progress(0)

func on_progress_complete() -> void:
	pass


func _on_character_health_changed(currentHealth: int) -> void:
	update_health_icon(currentHealth)
