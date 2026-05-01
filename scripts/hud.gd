extends Control

@export var progressBar: ProgressBar

func _ready() -> void:
	set_progress(0)

func _process(delta: float) -> void:
	var progress = progressBar.value
	progress += delta * 10
	set_progress(progress)

func set_progress(value: float) -> void:
	progressBar.value = value
	if value >= progressBar.max_value:
		on_progress_complete()
		set_progress(0)

func on_progress_complete() -> void:
	pass
