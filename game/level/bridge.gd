class_name Bridge
extends Area2D

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullets") && visible == true:
		SignalBus.checkpoint_reached.emit(self)
		hide()
		print_debug("Bridge destroyed!")


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("players") && visible == true:
		SignalBus.player_hit_bridge.emit()
		print_debug("Collided with bridge!")
