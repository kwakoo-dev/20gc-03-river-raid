extends Node2D

var speed = 0

func _input(event: InputEvent) -> void:
	if event.is_action("accelerate"):
		speed += 1
	if event.is_action("decelerate"):
		speed -= 1

func _process(delta: float) -> void:
	$Level1.position.y += delta * speed
	
	$Level1._get_bank_change(true)
