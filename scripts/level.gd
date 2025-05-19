extends Node2D

const SPEED = 500.0

@export var accelerate : StringName
@export var decelerate : StringName

func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed(accelerate):
		velocity.y = -SPEED
	elif Input.is_action_pressed(decelerate):
		velocity.y = SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED) 
	move_and_slide()
