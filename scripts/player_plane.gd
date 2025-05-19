extends CharacterBody2D

const SPEED = 500.0

@export var move_left : StringName
@export var move_right : StringName

func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed(move_left):
		velocity.x = -SPEED
	elif Input.is_action_pressed(move_right):
		velocity.x = SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED) 
	move_and_slide()
