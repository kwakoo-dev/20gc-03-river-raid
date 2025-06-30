extends Node2D

@export var level_scene : PackedScene
@export var level_drawing_component : LevelDrawingComponent
@export var player : PlayerPlane

var current_level : LevelV3
var previous_level : LevelV3 = null
var current_checkpoint : Bridge = null

func _ready() -> void:
	create_new_level(0)
	current_checkpoint = current_level.bridge
	current_checkpoint.hide()
	SignalBus.show_get_ready.emit()
	SignalBus.checkpoint_reached.connect(on_checkpoint_reached)
	SignalBus.player_hit_bridge.connect(on_player_death)
	SignalBus.player_hit_wall.connect(on_player_death)

func _process(_delta: float) -> void:
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

func _on_tree_exiting() -> void:
	print_orphan_nodes()

func on_checkpoint_reached(bridge : Bridge) -> void:
	SignalBus.show_checkpoint_reached.emit()
	current_checkpoint = bridge

func on_player_death() -> void:
	SignalBus.show_player_died.emit()
	current_checkpoint.hide()
	player.global_position = current_checkpoint.global_position - Vector2(0, 200)
