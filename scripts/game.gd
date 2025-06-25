extends Node2D

@export var level_scene : PackedScene
@export var level_drawing_component : LevelDrawingComponent

var current_level : LevelV3
var previous_level : LevelV3 = null

func _ready() -> void:
	create_new_level(0)

func _process(delta: float) -> void:
	if current_level.drawing_ended():
		create_new_level(current_level.get_level_end_y())

func create_new_level(position_y : int) -> void:
	print_debug("NEW LEVEL")
	var new_level : LevelV3 = level_scene.instantiate()
	new_level.global_position.x = 0
	new_level.global_position.y = position_y
	print_debug("Level global position: " + str(new_level.global_position))
	add_child(new_level)
	if previous_level:
		previous_level.queue_free()
	previous_level = current_level
	current_level = new_level
	level_drawing_component.set_level(new_level)
