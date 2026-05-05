extends CharacterBody2D

const JUMP_VELOCITY = -1200.0
const BEAM_OFFSET = 150

var hanging = false
var shootable = true
var jumpable = true
var lastDirection: int = 1
var direction: int = 1
var attackable = true
var hat: Node2D = null

@export var health= 3
@export var hat_scene: PackedScene
@export var speed: float = 1000.0

@onready var melee_hitbox = $MeleeHitbox
@onready var hitbox_shape = $MeleeHitbox/CollisionShape2D
@onready var hitbox_sprite = $MeleeHitbox/Sprite2D #da para tirar dps
func _ready() -> void:
	hitbox_sprite.hide()

func disable_collision_temp(mask,temp):
	set_collision_mask_value(mask,false)
	await get_tree().create_timer(temp).timeout
	set_collision_mask_value(mask,true)

func take_damage(amount):
	self.health-=amount

func throw_hat():
	shootable=false
	attackable=false
	hat = hat_scene.instantiate()
	hat.direction = direction
	if direction==0:
		hat.direction = lastDirection
	hat.global_position=global_position + Vector2(hat.direction*130,-20)
	get_tree().current_scene.add_child(hat)
	get_node("HatCooldown").start()
	attackable=true
	 
func recover_hat():
	get_node("HatCooldown").stop()
	shootable=true
	if is_instance_valid(hat):
		hat.queue_free()

func update_animations():
	$AnimatedSprite2D.flip_h = lastDirection < 0
	if direction!=0:
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("idle")
func melee_attack():
	attackable=false
	hitbox_shape.disabled = false
	hitbox_sprite.show()
	await get_tree().create_timer(0.2).timeout
	update_animations()
	hitbox_sprite.hide()
	hitbox_shape.disabled = true
	attackable=true

func _physics_process(delta: float) -> void:
	direction = Input.get_axis("left", "right")
	if direction < 0:
		melee_hitbox.position.x = -80
		lastDirection = direction
	if direction > 0:
		melee_hitbox.position.x = 0
		lastDirection = direction
	
	if Input.is_action_just_pressed("melee") and attackable:
		melee_attack()

	if direction:
		self.velocity.x = direction * speed
	else:
		self.velocity.x = move_toward(self.velocity.x, 0, speed)
	#gravidade pq ta no ar
	if shootable and Input.is_action_pressed("shoot"):
		throw_hat()
	
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
		disable_collision_temp(1,0.15)
		self.velocity.y = JUMP_VELOCITY

	move_and_slide()
	update_animations()
func _on_hat_cooldown_timeout() -> void:
	recover_hat()


func _on_melee_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(1)
