extends CharacterBody2D
var hanging  = false
var shootable=true
const JUMP_VELOCITY = -1200.0
@export var speed: float = 400.0

func _ready() -> void:
	pass
func disable_collision_temp():
	set_collision_mask_value(1,false)
	await get_tree().create_timer(0.3).timeout
	set_collision_mask_value(1,true)
	
func _physics_process(delta: float) -> void:
	#gravidade pq ta no ar
	if shootable and Input.is_action_pressed("shoot"):
		shootable=false
		get_node("HatCooldown").start()
		print("atirei")
	
	var jumpable=true
	if not is_on_floor() and not is_on_ceiling():
		self.velocity += get_gravity() * delta
		jumpable=false
	#ta pendurado
	
	if is_on_ceiling():
		if Input.is_action_just_pressed("up"):
			position[1] -=250
		if Input.is_action_just_pressed("down"):
			self.velocity += get_gravity() * delta
	elif  is_on_floor() and Input.is_action_just_pressed("down"):
			position[1] +=250
	
	if jumpable and Input.is_action_just_pressed("jump"):
		disable_collision_temp()
		self.velocity.y = JUMP_VELOCITY
	
	
	var direction := Input.get_axis("left", "right")
	if direction:
		self.velocity.x = direction * speed
	else:
		self.velocity.x = move_toward(self.velocity.x, 0, speed)

	move_and_slide()


func _on_hat_cooldown_timeout() -> void:
	shootable=true
	print("voltou o chapeu")
