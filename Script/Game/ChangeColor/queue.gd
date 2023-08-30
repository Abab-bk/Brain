extends VisibleOnScreenNotifier2D

func _process(delta: float) -> void:
    get_parent().position.x -= 2.5
func _on_screen_exited() -> void:
    get_parent().queue_free()
