extends VisibleOnScreenNotifier2D

const _speed = 2.5

func _process(delta: float) -> void:
    get_parent().position.x -= _speed
func _on_screen_exited() -> void:
    get_parent().queue_free()
