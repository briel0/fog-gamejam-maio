extends CharacterBody2D

@export var speed: float = 200.0

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("left", "right")
	if direction:
		self.velocity.x = direction * speed
	else:
		self.velocity.x = move_toward(self.velocity.x, 0, speed)

	move_and_slide()
