extends Area2D

@export var speed: float = 700.0
var direction: int = 1 # 1 para direita, -1 para esquerda

func _physics_process(delta: float) -> void:
	position.x += speed * direction * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	# Colocar lógica de dano depois
	queue_free()
