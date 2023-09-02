extends Control

@onready var animation_player:AnimationPlayer = $"../AnimationPlayer"
@onready var check_box:TextureButton = %CheckBox
@onready var h_slider:HSlider = %HSlider
@onready var label:Label = %Label
@onready var button:Button = %Apply
@onready var _save:Button = %save
@onready var _load:Button = %load
@onready var _back_btn:Button = $MarginContainer/VBoxContainer/MarginContainer/Body/MarginContainer/VBoxContainer/BackMain/MarginContainer/BackBtn

var _main_scene := preload("res://Scene/Start.tscn")

func apply(_nothing:float = 0.0) -> void:
    AudioServer.set_bus_mute(0, check_box.button_pressed)
    AudioServer.set_bus_volume_db(0, h_slider.value)

func _on_texture_button_pressed() -> void:
    get_parent().hide()

func _on_canvas_layer_visibility_changed() -> void:
    Master.save_game()
    if get_tree().current_scene.name == "Start":
        return
    get_tree().paused = get_parent().visible

func _ready() -> void:
    _save.pressed.connect(Callable(Master,"save_game"))
    _load.pressed.connect(Callable(Master,"load_game"))
    _back_btn.pressed.connect(func():
        get_tree().change_scene_to_packed(_main_scene))
    check_box.pressed.connect(self.apply)
    h_slider.value_changed.connect(self.apply)
