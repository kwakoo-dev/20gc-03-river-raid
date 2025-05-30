extends Node2D

var speed = 0

func _input(event: InputEvent) -> void:
	if event.is_action("accelerate"):
		speed += 5
	if event.is_action("decelerate"):
		speed -= 5

func _process(delta: float) -> void:
	$Level.position.y += delta * speed
