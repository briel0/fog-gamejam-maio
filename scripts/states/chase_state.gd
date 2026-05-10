class_name ChaseState extends State

@export var speed: float = 150.0 # Mais rápido que a patrulha
var direction: float = 1.0

@onready var sprite: Sprite2D = $"../../Sprite2D"
@onready var ledge_check: RayCast2D = $"../../RayCast2D"

func physics_update(delta: float) -> void:
    if not enemy.is_on_floor():
        enemy.velocity += enemy.get_gravity() * delta
        
    if enemy.target != null:
        var distance_to_target = enemy.target.global_position.x - enemy.global_position.x
        direction = sign(distance_to_target)

        if direction != 0:
            sprite.flip_h = (direction > 0)
            ledge_check.position.x = abs(ledge_check.position.x) * direction
            
    if enemy.is_on_wall() or not ledge_check.is_colliding():
        enemy.velocity.x = 0 
    else:
        enemy.velocity.x = speed * direction
        
    enemy.move_and_slide()
