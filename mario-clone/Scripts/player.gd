extends CharacterBody2D

@export var move_speed = 140.0
@export var jump_force = -300.0
@export var gravity_value = 900.0

signal pickup
signal damage_taken

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("coins"):
		area.pickup()
		emit_signal("pickup")  # just emit signal

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity_value * delta  # use built-in velocity

	var direction = Input.get_axis("move_left", "move_right")

	if direction != 0:
		velocity.x = direction * move_speed
		$AnimatedSprite2D.flip_h = direction < 0
		if is_on_floor():
			$AnimatedSprite2D.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
		if is_on_floor():
			$AnimatedSprite2D.play("Idle")

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
		$AnimatedSprite2D.play("Jump")

	if !is_on_floor():
		$AnimatedSprite2D.play("Jump")

	move_and_slide()

func _on_area_2d_body_entered(body):
	if body.is_in_group("slime"):
		if velocity.y > 0 and global_position.y < body.global_position.y:
			body.die()
			velocity.y = jump_force * 0.6
		else:
			emit_signal("damage_taken")
