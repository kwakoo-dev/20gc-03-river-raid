extends Node2D

@export var accelerate : StringName
@export var decelerate : StringName
## The bigger the value, the more straight the river is
@export var river_straightness : int = 10
@export var level_length : int = 300

@onready var _grassLayer : TileMapLayer = $GrassLayer
@onready var _waterLayer : TileMapLayer = $WaterLayer

enum BankChange {
	NO_CHANGE,
	WIDER,
	NARROWER
}

const MAX_SPEED : float = 1000.0

var speed : float = 500.0

const BRIDGE_WIDTH : int = 12
const LEVEL_WIDTH : int = 40
var bank_left : int = (LEVEL_WIDTH - BRIDGE_WIDTH) / 2
var bank_right : int = bank_left + BRIDGE_WIDTH

var grass_y : int = 0
var water_y : int = 0

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fire"):
		var start = Time.get_ticks_usec()
		draw_river_bank_block(grass_y, level_length)
		draw_water_block(water_y, level_length)
		grass_y += level_length
		water_y += level_length / 2
		var end = Time.get_ticks_usec()
		var diff = (end - start) / 1000000.0
		print_debug("draw_river_bank_block: " + str(diff))

func _can_get_narrower() -> bool:
	return bank_right - bank_left > BRIDGE_WIDTH

func _can_left_get_wider() -> bool:
	return bank_left > 2
	
func _can_right_get_wider() -> bool:
	return bank_right < LEVEL_WIDTH - 2
	
func _get_bank_change(can_get_wider : bool) -> BankChange:
	var change : BankChange = _get_random_bank_change()
	if change == BankChange.NARROWER && _can_get_narrower():
		return change
	if change == BankChange.WIDER && can_get_wider:
		return change
	return BankChange.NO_CHANGE
	

func _get_random_bank_change() -> BankChange:
	var result : int  = randi_range(0, clampi(river_straightness, 2, 1000))
	if result == 0:
		return BankChange.NARROWER
	if result == 1:
		return BankChange.WIDER
	return BankChange.NO_CHANGE

func draw_water_block(y : int, block_size : int) -> void:
	var actual_block_size = block_size / 2
	for i in range(actual_block_size):
		for x in range(LEVEL_WIDTH / 2):
			_waterLayer.set_cell(Vector2i(x, y), 0, Vector2i(0,0))
		y += 1
	

func draw_river_bank_block(y : int, block_size : int) -> void:
	var block : Array[Vector2i] = []
	for i in range(block_size):
		var line : Array[Vector2i] = get_river_line(y)
		block.append_array(line)
		y += 1
	put_grass(block)

func get_river_line(y : int) -> Array[Vector2i]:
	var line : Array[Vector2i]
	var bank_left_change : BankChange = _get_bank_change(_can_left_get_wider())
	var bank_right_change : BankChange = _get_bank_change(_can_right_get_wider())
	match bank_left_change:
		BankChange.WIDER:
			bank_left -= 1
		BankChange.NARROWER:
			bank_left += 1
	match bank_right_change:
		BankChange.WIDER:
			bank_right += 1
		BankChange.NARROWER:
			bank_right -= 1
	for x in range(0, bank_left):
		line.append(Vector2i(x, y))
	for x in range(bank_right, LEVEL_WIDTH):
		line.append(Vector2i(x, y))
	return line

func put_grass(cells: Array[Vector2i]) -> void:
	_grassLayer.set_cells_terrain_connect(cells, 0, 0, false)
	pass
	
