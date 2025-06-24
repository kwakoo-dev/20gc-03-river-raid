class_name LevelDrawingComponent
extends Node

@export
var level : LevelV3
@export
var camera : Camera2D
@export
var draw_distance : int = 500



func _process(delta: float) -> void:
	var level_end_y = level.get_level_end_y()
	var camera_position_y = camera.get_screen_center_position().y
	var camera_with_draw_distance_y = camera_position_y - draw_distance
	if level_end_y < camera_with_draw_distance_y:
		return
		
	level.draw_level()
