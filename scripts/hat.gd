extends CharacterBody2D

var gravidade = ProjectSettings.get_setting("physics/2d/default_gravity")
var velocidade_arremesso: Vector2 = Vector2(850, -800) 
var no_chao: bool = false
var direction: int = 1
var pode_ser_coletado

func _ready():
	velocity = Vector2(velocidade_arremesso.x * direction, velocidade_arremesso.y)
	await get_tree().create_timer(0.2).timeout
	pode_ser_coletado = true

func _physics_process(delta):
	if not no_chao:
		velocity.y += gravidade * delta
		var colisao = move_and_collide(velocity * delta)
		if colisao:
			var normal = colisao.get_normal()       
			if normal.y < -0.5: 
				no_chao = true
				velocity = Vector2.ZERO 
			elif abs(normal.x) > 0.5:
				velocity.x = -velocity.x
				velocity.x *= 0.8 
func _on_area_coleta_body_entered(body):
	print("achou")
	if not pode_ser_coletado:
		return
	if body.has_method("recover_hat"):
		body.recover_hat()
