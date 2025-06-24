extends CharacterBody2D

@onready var _sprites = $Sprites

@export var SPEED = 5.0

@export var move_left : StringName
@export var move_right : StringName

func _physics_process(delta: float) -> void:
	var input_direction = Input.get_vector("left", "right", "accelerate", "decelerate")
	velocity = input_direction * SPEED
	
	if velocity.x < 0:
		_sprites.play("left")
	elif  velocity.x > 0:
		_sprites.play("right")
	else:
		_sprites.play("default")
	
	move_and_collide(velocity)
