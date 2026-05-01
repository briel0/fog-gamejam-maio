extends CharacterBody2D

const JUMP_VELOCITY = -800.0
@export var speed: float = 400.0

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		self.velocity += get_gravity() * delta
	else:
		if Input.is_action_just_pressed("jump"):
			self.velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("left", "right")
	if direction:
		self.velocity.x = direction * speed
	else:
		self.velocity.x = move_toward(self.velocity.x, 0, speed)

	move_and_slide()
