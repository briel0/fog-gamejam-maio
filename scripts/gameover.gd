extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	position = Vector2.ZERO
	size = get_viewport_rect().size
	if has_node("Overlay"):
		$Overlay.size = get_viewport_rect().size
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
