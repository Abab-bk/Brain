extends Control

@onready var animation_player:AnimationPlayer = $"../AnimationPlayer"
@onready var check_box:CheckBox = %CheckBox
@onready var h_slider:HSlider = %HSlider
@onready var label:Label = %Label
@onready var button:Button = %Apply
@onready var _save:Button = %save
@onready var _load:Button = %load

func _on_button_pressed() -> void:
    AudioServer.set_bus_mute(0, not check_box.button_pressed)
    AudioServer.set_bus_volume_db(0, h_slider.value)

func _on_texture_button_pressed() -> void:
    if get_tree().current_scene.name == "Start":
        get_parent().visible = false
    hide()
#    animation_player.play("new_animation")
    await animation_player.animation_finished
    await get_tree().create_timer(0.1).timeout
    get_parent().visible = false
    label.hide()
    show()

func _on_canvas_layer_visibility_changed() -> void:
    if get_tree().current_scene.name == "Start":
        return
    get_tree().paused = get_parent().visible

func _ready() -> void:
    _save.pressed.connect(Callable(Master,"save_game"))
    _load.pressed.connect(Callable(Master,"load_game"))
