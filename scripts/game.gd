extends Node2D


var speed = 100

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("accelerate"):
		speed += 10
	if event.is_action_pressed("decelerate"):
		speed -= 10

func _process(delta: float) -> void:
	$Level1.position.y += delta * speed
	draw_ascii_level(delta)


enum BankChange {
	NO_CHANGE,
	WIDER,
	NARROWER
}

var cycle : int = 0
var current_offset : float = 0.0
var interal : float = 100.0

const line_WIDTH : int = 6
const LEVEL_WIDTH : int = 24
const NARROWEST : int = 2

var bank_left : int = (LEVEL_WIDTH - line_WIDTH)  / 2
var bank_right : int = bank_left + line_WIDTH

func draw_ascii_level(delta: float) -> void:
	current_offset += delta * speed
	if current_offset < interal:
		return
	current_offset = 0
	
	if cycle == 0:
		draw_bridge()
	else:
		draw_river()
	
	cycle += 1

func draw_bridge() -> void:
	var line : String = ""
	var road_width = (LEVEL_WIDTH - line_WIDTH)  / 2
	
	for x in range(road_width):
		line += "="
	for x in range(line_WIDTH):
		if x % 2 == 0:
			line += "["
		else:
			line += "]"
	for x in range(road_width):
		line += "="
	print(line)

func draw_river() -> void:
	var line : String = ""
	var x : int = 0
	
	var bank_left_change : BankChange = get_bank_change(can_left_get_wider())
	var bank_right_change : BankChange = get_bank_change(can_right_get_wider())
	match bank_left_change:
		BankChange.WIDER:
			bank_left -= 1
		BankChange.NARROWER:
			bank_left += 1
			
	match bank_right_change:
		BankChange.WIDER:
			bank_right -= 1
		BankChange.NARROWER:
			bank_right += 1
	
	while x < bank_left:
		line += "#"
		x += 1
	while x < bank_right:
		line += "~"
		x += 1
	while x < LEVEL_WIDTH:
		line += "#"
		x += 1
	print(line)

func can_get_narrower() -> bool:
	return bank_right - bank_left > NARROWEST

func can_left_get_wider() -> bool:
	return bank_left > 2
	
func can_right_get_wider() -> bool:
	return bank_right < LEVEL_WIDTH - 2
	
func get_bank_change(can_get_wider : bool) -> BankChange:
	var change : BankChange = get_random_bank_change()
	if change == BankChange.NARROWER && can_get_narrower():
		return change
	if change == BankChange.WIDER && can_get_wider:
		return change
	return BankChange.NO_CHANGE
	

func get_random_bank_change() -> BankChange:
	var result : int  = randi_range(0, 9)
	if result == 0:
		return BankChange.NARROWER
	if result == 1:
		return BankChange.WIDER
	return BankChange.NO_CHANGE
	
	
