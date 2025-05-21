extends Node2D

@export var accelerate : StringName
@export var decelerate : StringName
const MAX_SPEED : float = 1000.0

var speed : float = 500.0

func process(delta: float) -> void:
	if Input.is_action_pressed(accelerate):
		speed = clampi(speed + 10, 0, MAX_SPEED)
	elif Input.is_action_pressed(decelerate):
		speed = clampi(speed - 10, 0, MAX_SPEED)
	position.y += speed * delta
