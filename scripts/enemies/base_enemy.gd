extends CharacterBody2D

@onready var health_component = $HealthComponent

func _ready() -> void:
    print("TOMOU")
    health_component.died.connect(_on_died)

func take_damage(amount: int) -> void:
    health_component.take_damage(amount)
    
    $Sprite2D.modulate = Color(1, 0, 0)
    await get_tree().create_timer(0.1).timeout
    $Sprite2D.modulate = Color(1, 1, 1)

func _on_died() -> void:
    queue_free()
    
func _on_damage_zone_body_entered(body: Node2D) -> void:
    if body.has_method("take_damage"):
        body.take_damage(1)
