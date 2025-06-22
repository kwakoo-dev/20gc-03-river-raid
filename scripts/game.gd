extends Node2D



func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fire2"):
		$PlayerPlane.position = Vector2(350, 664)

func _process(delta: float) -> void:
	pass
	#$Level.position.y += delta * speed
