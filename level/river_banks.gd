class_name RiverBanks
extends RefCounted

var left : int = Properties.DEFAULT_BANK_LEFT
var right : int = Properties.DEFAULT_BANK_RIGHT

enum BankChange {
	NO_CHANGE,
	WIDER,
	NARROWER
}

static func create(new_left : int, new_right : int) -> RiverBanks:
	var riverBanks = RiverBanks.new()
	riverBanks.left = new_left
	riverBanks.right = new_right
	return riverBanks

func change_river_banks() -> void:
	var left_bank_change : BankChange = _get_random_bank_change()
	var right_bank_change : BankChange = _get_random_bank_change()
	
	match left_bank_change:
		BankChange.WIDER:
			left -= 1
		BankChange.NARROWER:
			left += 1
	match right_bank_change:
		BankChange.WIDER:
			right += 1
		BankChange.NARROWER:
			right -= 1
	left = clampi(left, Properties.MIN_BANK_LEFT, Properties.DEFAULT_BANK_LEFT)
	right = clampi(right, Properties.DEFAULT_BANK_RIGHT, Properties.MAX_BANK_RIGHT)

## returns true if banks are at correct position after adjustment. 
## Meant to be called repeatedly until banks are changed to a correct position
func adjust_river_banks(left_dest : int, right_dest : int) -> bool:
	_perform_adjust_river_banks(left_dest, right_dest)
	return left == left_dest || right == right_dest

func _perform_adjust_river_banks(left_dest : int, right_dest : int) -> void:
	if left < left_dest:
		left += 1
	elif left > left_dest:
		left -= 1
	if right < right_dest:
		right += 1
	elif right > right_dest:
		right -= 1

func _get_random_bank_change() -> BankChange:
	var result : int  = randi_range(0, clampi(Properties.RIVER_STRAIGHTNESS, 2, 1000))
	if result == 0:
		return BankChange.NARROWER
	if result == 1:
		return BankChange.WIDER
	return BankChange.NO_CHANGE

func get_river_banks_line(y : int) -> Array[Vector2i]:
	var line : Array[Vector2i]
	for x in range(0, left):
		line.append(Vector2i(x, y))
	for x in range(right, Properties.LEVEL_WIDTH):
		line.append(Vector2i(x, y))
	return line
