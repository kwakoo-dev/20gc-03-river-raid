extends Node2D

@export var level_scene : PackedScene
@export var level_drawing_component : LevelDrawingComponent

var current_level : LevelV3

func _ready() -> void:
	create_new_level(0)

func _process(delta: float) -> void:
	if current_level.drawing_ended():
		create_new_level(current_level.get_end_y())

func create_new_level(position_y : int) -> void:
	print_debug("NEW LEVEL")
	var new_level : LevelV3 = level_scene.instantiate()
	new_level.position.x = 0
	new_level.position.y = position_y
	add_child(new_level)
	current_level = new_level
	level_drawing_component.set_level(new_level)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fire2"):
		$PlayerPlane.position = Vector2(350, 664)
