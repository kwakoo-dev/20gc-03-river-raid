extends CanvasLayer

var get_ready_shown = false

func _ready() -> void:
	SignalBus.show_get_ready.connect(show_get_ready)
	SignalBus.show_checkpoint_reached.connect(show_checkpoint)
	SignalBus.show_player_died.connect(show_you_died)
	$GetReadyLabel.hide()
	$CheckpointLabel.hide()
	$YouDied.hide()

func _process(delta: float) -> void:
	scroll_text(delta, $GetReadyLabel)
	scroll_text(delta, $CheckpointLabel)
	scroll_text(delta, $YouDied)

func scroll_text(delta: float, label : Label) -> void:
	if label.visible:
		label.position.x -= delta * Properties.INFO_SCROLL_SPEED
	if label.position.x < -Properties.TEXT_SCROLL_MARGIN:
		label.hide()
		label.position.x = Properties.TEXT_SCROLL_MARGIN

func show_get_ready() -> void:
	$GetReadyLabel.show()
	
func show_checkpoint() -> void:
	$CheckpointLabel.show()

func show_you_died() -> void:
	$YouDied.show()
