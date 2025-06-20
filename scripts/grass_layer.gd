extends TileMapLayer
class_name GrassLayer

## How long the straight "corridor" at the beginning of the level is.
@export var level_start_length : int = 24
## The bigger the value, the more straight the river is.
@export var river_straightness : int = 10

enum BankChange {
	NO_CHANGE,
	WIDER,
	NARROWER
}

## in blocks
const LEVEL_WIDTH : int = 40
const BRIDGE_WIDTH : int = 12
const NARROWEST : int = 8
const DEFAULT_BANK_LEFT : int = (LEVEL_WIDTH - BRIDGE_WIDTH) / 2
const DEFAULT_BANK_RIGHT : int = DEFAULT_BANK_LEFT + BRIDGE_WIDTH
const MIN_BANK_LEFT : int = 2
const MAX_BANK_RIGHT : int = LEVEL_WIDTH - MIN_BANK_LEFT
const MIN_ISLAND_LEFT : int = MIN_BANK_LEFT + NARROWEST
const MAX_ISLAND_RIGHT : int = MAX_BANK_RIGHT - NARROWEST
const OPENING_LEFT : int = DEFAULT_BANK_LEFT - 5
const OPENING_RIGHT : int = DEFAULT_BANK_RIGHT + 5
const MIDDLE_X : int = (DEFAULT_BANK_RIGHT + DEFAULT_BANK_LEFT) / 2

var bank_left : int = DEFAULT_BANK_LEFT
var bank_right : int = DEFAULT_BANK_RIGHT

#var bank_left : int = OPENING_LEFT
#var bank_right : int = OPENING_RIGHT

var island_left : int = DEFAULT_BANK_LEFT
var island_right : int = DEFAULT_BANK_RIGHT

func draw_level_start(start_y : int) -> int:
	var block : Array[Vector2i] = []
	var segment_length : int = 0
	var corridor_end_y = start_y - level_start_length
	for y in range(start_y, corridor_end_y, -1):
		block.append_array(_get_river_banks_line(y))
		segment_length += 1
		
	var y = corridor_end_y
	while not (bank_left == OPENING_LEFT && bank_right == OPENING_RIGHT):
		_adjust_river_banks(OPENING_LEFT, OPENING_RIGHT, y)
		block.append_array(_get_river_banks_line(y))
		segment_length += 1
		y -= 1

	_put_grass(block)
	return segment_length

func draw_level_end(start_y : int) -> int:
	var block : Array[Vector2i] = []
	var y : int = start_y
	var segment_length : int = 0
	
	while not (bank_left == DEFAULT_BANK_LEFT && bank_right == DEFAULT_BANK_RIGHT):
		_adjust_river_banks(DEFAULT_BANK_LEFT, DEFAULT_BANK_RIGHT, y)	
		block.append_array(_get_river_banks_line(y))
		y -= 1
		segment_length += 1
	
	_put_grass(block)
	return segment_length

func draw_river(y : int, block_size : int) -> int:
	var block : Array[Vector2i] = []
	for i in range(block_size):
		var line : Array[Vector2i] = _get_river_line(y)
		block.append_array(line)
		y -= 1
	_put_grass(block)
	return block_size

func draw_island_start(y : int) -> int:
	var block : Array[Vector2i] = []
	var segment_length : int = 0
	
	while not (bank_left == MIN_BANK_LEFT && bank_right == MAX_BANK_RIGHT):
		_adjust_river_banks(MIN_BANK_LEFT, MAX_BANK_RIGHT, y)
		block.append_array(_get_river_banks_line(y))
		segment_length += 1
		y -= 1

	_put_grass(block)
	return segment_length

# todo: almost a duplicate of _draw_river - only diff is _get_island_line
func draw_island(y : int, block_size : int) -> int:
	island_left = DEFAULT_BANK_LEFT
	island_right = DEFAULT_BANK_RIGHT
	var block : Array[Vector2i] = []
	for i in range(block_size):
		var line : Array[Vector2i] = _get_island_line(y)
		block.append_array(line)
		y -= 1
	_put_grass(block)
	return block_size

func _get_river_line(y : int) -> Array[Vector2i]:
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
	return _get_river_banks_line(y)
	
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

func _can_get_narrower() -> bool:
	return bank_right - bank_left > BRIDGE_WIDTH

func _can_left_get_wider() -> bool:
	return bank_left > MIN_BANK_LEFT
	
func _can_right_get_wider() -> bool:
	return bank_right < MAX_BANK_RIGHT

func _get_river_banks_line(y : int) -> Array[Vector2i]:
	var line : Array[Vector2i]
	for x in range(0, bank_left):
		line.append(Vector2i(x, y))
	for x in range(bank_right, LEVEL_WIDTH):
		line.append(Vector2i(x, y))
	return line

func _adjust_river_banks(left_dest : int, right_dest : int, y : int) -> void:
	if y % 2 == 0:
		return
	if bank_left < left_dest:
		bank_left += 1
	elif bank_left > left_dest:
		bank_left -= 1
	if bank_right < right_dest:
		bank_right += 1
	elif bank_right > right_dest:
		bank_right -= 1

func _get_island_line(y : int) -> Array[Vector2i]:
	var bank_left_change : BankChange = _get_island_bank_change(_can_island_left_get_wider())
	var bank_right_change : BankChange = _get_island_bank_change(_can_island_right_get_wider())
	match bank_left_change:
		BankChange.WIDER:
			island_left -= 1
		BankChange.NARROWER:
			island_left += 1
	match bank_right_change:
		BankChange.WIDER:
			island_right += 1
		BankChange.NARROWER:
			island_right -= 1
	return _get_island_banks_line(y)

func _get_island_bank_change(can_get_wider : bool) -> BankChange:
	var change : BankChange = _get_random_bank_change()
	if change == BankChange.NARROWER:
		return change
	if change == BankChange.WIDER && can_get_wider:
		return change
	return BankChange.NO_CHANGE

func _can_island_left_get_wider() -> bool:
	return island_left > MIN_ISLAND_LEFT
	
func _can_island_right_get_wider() -> bool:
	return island_right < MAX_ISLAND_RIGHT
	
func _get_island_banks_line(y : int) -> Array[Vector2i]:
	var line : Array[Vector2i]
	line.append_array(_get_river_banks_line(y))
	for x in range(island_left, island_right):
		line.append(Vector2i(x, y))
	return line

func _put_grass(cells: Array[Vector2i]) -> void:
	set_cells_terrain_connect(cells, 0, 0, false)
	pass
