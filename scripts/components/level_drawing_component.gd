class_name LevelDrawingComponent
extends Node

@export
var level : LevelV3
@export
var camera : Camera2D

func set_level(level : LevelV3) -> void:
	self.level = level

func _process(delta: float) -> void:
	if level.drawing_ended():
		return
	var level_end_y = level.get_level_end_y()
	var camera_position_y = camera.get_screen_center_position().y
	var camera_with_draw_distance_y = camera_position_y - Properties.DRAWING_DISTANCE
	if level_end_y < camera_with_draw_distance_y:
		return
	level.draw_level()
