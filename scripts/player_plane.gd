extends CharacterBody2D

@onready var _sprites = $Sprites

const SPEED = 5.0

@export var move_left : StringName
@export var move_right : StringName

func _physics_process(delta: float) -> void:
	var input_direction = Input.get_vector("left", "right", "accelerate", "decelerate")
	velocity = input_direction * SPEED
	move_and_collide(velocity)
