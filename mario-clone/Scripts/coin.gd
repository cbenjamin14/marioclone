extends Area2D

signal add_point

func _on_area_entered(body) -> void:
	print("collided")
	if body.name == "Player":
		emit_signal("add_point")
		queue_free()
