class_name Island
extends RefCounted

var left : int = Properties.DEFAULT_BANK_LEFT
var right : int = Properties.DEFAULT_BANK_RIGHT

enum BankChange {
	NO_CHANGE,
	WIDER,
	NARROWER
}

func change_island_banks() -> void:
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
	left = clampi(left, Properties.MIN_ISLAND_LEFT, Properties.DEFAULT_BANK_RIGHT)
	right = clampi(right, Properties.DEFAULT_BANK_LEFT, Properties.MAX_ISLAND_RIGHT)


func _get_random_bank_change() -> BankChange:
	var result : int  = randi_range(0, clampi(Properties.RIVER_STRAIGHTNESS, 2, 1000))
	if result == 0:
		return BankChange.NARROWER
	if result == 1:
		return BankChange.WIDER
	return BankChange.NO_CHANGE

func get_river_banks_line(y : int, river_banks : RiverBanks) -> Array[Vector2i]:
	var line : Array[Vector2i] = river_banks.get_river_banks_line(y)
	for x in range(left, right):
		line.append(Vector2i(x, y))
	return line
