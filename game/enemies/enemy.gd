extends Node2D

@export var ray_cast_right : RayCast2D
@export var ray_cast_left : RayCast2D
@export var sprite : AnimatedSprite2D

var direction : int = 1

func _process(delta: float) -> void:
	position.x += delta * direction * Properties.ENEMY_SPEED

	if ray_cast_left.is_colliding():
		direction = 1
		sprite.flip_h = false
	if ray_cast_right.is_colliding():
		direction = -1
		sprite.flip_h = true
