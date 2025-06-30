class_name PlayerPlane
extends CharacterBody2D

@onready var _sprites = $Sprites
@export var bullet_scene : PackedScene
@export var gun : Marker2D

var last_shoot_msec : int = 0

func _process(delta: float) -> void:
	var x_axis : float = Input.get_axis("left", "right")
	var y_axis : float = Input.get_axis("accelerate", "decelerate")
	
	if x_axis < 0:
		_sprites.play("left")
	elif  x_axis > 0:
		_sprites.play("right")
	else:
		_sprites.play("default")
		
	if Input.is_action_pressed("fire"):
		try_shooting()
	
	if abs(x_axis) < Properties.PLANE_TURN_DEAD_ZONE:
		velocity.x = 0
	else:
		velocity.x += x_axis * Properties.PLANE_TURN_SPEED * delta
	velocity.y += y_axis * Properties.PLANE_ACCELERATION * delta
	velocity.y = clampf(velocity.y, -Properties.PLANE_MAX_SPEED, -Properties.PLANE_MIN_SPEED)

func _physics_process(delta: float) -> void:
	var collision : KinematicCollision2D = move_and_collide(velocity * delta)
	if collision:
		handle_collision(collision)

func handle_collision(collision : KinematicCollision2D) -> void:
	var collider : Object = collision.get_collider()
	if collider.is_in_group("walls"):
		SignalBus.player_hit_wall.emit()

func try_shooting() -> void:
	if Time.get_ticks_msec() < last_shoot_msec + Properties.WEAPON_COOLDOWN:
		return
	last_shoot_msec = Time.get_ticks_msec()
	var bullet : Bullet = bullet_scene.instantiate()
	owner.add_child(bullet)
	bullet.global_position = gun.global_position
