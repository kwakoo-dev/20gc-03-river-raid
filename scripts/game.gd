extends Node2D


var speed = 100

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("accelerate"):
		speed += 10
	if event.is_action_pressed("decelerate"):
		speed -= 10

func _process(delta: float) -> void:
	
	$Level1.position.y += delta * speed
	
	pass
