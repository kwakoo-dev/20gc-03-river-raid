class_name Bullet
extends Area2D

func _process(delta: float) -> void:
	position.y -= delta * Properties.BULLET_SPEED


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("players"):
		queue_free()
