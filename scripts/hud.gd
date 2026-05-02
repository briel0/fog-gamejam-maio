extends Control

@export var progressBar: ProgressBar
@export var lifeBar: HBoxContainer
@export var lifeIcon: Texture

func _ready() -> void:
	set_progress(0)
	set_life(3)

func _process(delta: float) -> void:
	var progress = progressBar.value
	progress += delta * 10
	set_progress(progress)

func set_life(life: int) -> void:
	var childCount = lifeBar.get_child_count()
	for i in range(childCount):
		var child = lifeBar.get_child(childCount - 1 - i)
		if child is TextureRect:
			if life > 0:
				child.texture = lifeIcon
				life -= 1
			else:
				child.texture = null

func set_progress(value: float) -> void:
	progressBar.value = value
	if value >= progressBar.max_value:
		on_progress_complete()
		set_progress(0)

func on_progress_complete() -> void:
	pass
