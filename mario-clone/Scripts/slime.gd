extends CharacterBody2D

@export var speed = 50.0
@export var gravity_value = 900.0
var direction = -1
var dead = false

func _physics_process(delta: float) -> void:
	if dead:
		return
	
	if !is_on_floor():
		velocity.y += gravity_value * delta
	
	velocity.x = direction * speed
	move_and_slide()
	if is_on_wall():
		direction *= -1
		$AnimatedSprite2D.flip_h = direction > 0

func die():
	dead = true
	$AnimatedSprite2D.play("dead")
	$CollisionShaped2D.disabled = true
	await get_tree().create_timer(0.4).timeout
	queue_free()
	
func _on_body_entered(body):
	if body.get_parent().name == "Player":
		var player = body.get_parent()
		
		if player.velocity.y > 0 and player.global_position.y < global_position.y:
			die()
			player.velocity.y = -200
		else:
			player.take_damage()
