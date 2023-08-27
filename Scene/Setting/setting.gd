extends Control
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

func _on_button_pressed() -> void:
	AudioServer.set_bus_mute(0,not $GridContainer/Panel/CheckBox.button_pressed)
	AudioServer.set_bus_volume_db(0,$GridContainer/Panel/HSlider.value)


func _on_texture_button_pressed() -> void:
	hide()
	animation_player.play("new_animation")
	await animation_player.animation_finished
	await get_tree().create_timer(0.1).timeout
	get_parent().visible = false
	$"../Label".hide()
	show()


func _on_canvas_layer_visibility_changed() -> void:
	get_tree().paused = get_parent().visible
