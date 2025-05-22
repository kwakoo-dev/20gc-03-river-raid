extends Node2D

var speed = 100

func _input(event: InputEvent) -> void:
	if event.is_action("accelerate"):
		speed += 10
	if event.is_action("decelerate"):
		speed -= 10

func _process(delta: float) -> void:
	$Level1.position.y += delta * speed
