extends CharacterBody2D
var hanging  = false
var shootable=true
var jumpable = true
const JUMP_VELOCITY = -1200.0
const BEAM_OFFSET = 250

@export var speed: float = 400.0
@export var bullet_scene: PackedScene
@onready var muzzle = $Muzzle
@onready var shoot_timer: Timer = $ShootTimer

var last_facing: int = 1

func handle_combat():
	if Input.is_action_just_pressed("shoot") and shoot_timer.is_stopped():
		shoot_timer.start()
		var b = bullet_scene.instantiate()
		get_tree().root.add_child(b)
		b.position = muzzle.global_position
		b.direction = last_facing

func _ready() -> void:
	pass
	
func disable_collision_temp():
	set_collision_mask_value(1,false)
	await get_tree().create_timer(0.3).timeout
	set_collision_mask_value(1,true)
	
func _physics_process(delta: float) -> void:
	if shootable and Input.is_action_pressed("shoot"):
		shootable=false
		get_node("HatCooldown").start()
		print("atirei")
	
	jumpable=true
	if not is_on_floor() and not is_on_ceiling():
		self.velocity += get_gravity() * delta
		jumpable=false
	
	if is_on_ceiling():
		if Input.is_action_just_pressed("up"):
			position.y -= BEAM_OFFSET
		if Input.is_action_just_pressed("down"):
			self.velocity += get_gravity() * delta
	elif is_on_floor() and Input.is_action_just_pressed("down"):
			position.y += BEAM_OFFSET
	
	if jumpable and Input.is_action_just_pressed("jump"):
		disable_collision_temp()
		self.velocity.y = JUMP_VELOCITY
	
	var direction := Input.get_axis("left", "right")
	if direction: 
		last_facing = sign(direction)
		muzzle.position.x = abs(muzzle.position.x) * last_facing
		
		self.velocity.x = direction * speed
	else:
		self.velocity.x = move_toward(self.velocity.x, 0, speed)

	move_and_slide()
	handle_combat()          

func _on_hat_cooldown_timeout() -> void:
	shootable=true
	print("voltou o chapeu")
