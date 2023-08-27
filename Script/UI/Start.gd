extends Control

@onready var _start_game:Button = $MarginContainer/Content/MarginContainer/VBoxContainer/StartGame
@onready var _option:Button = $MarginContainer/Content/MarginContainer/VBoxContainer/Option
@onready var _quit:Button = $MarginContainer/Content/MarginContainer/VBoxContainer/Quit

var _game_world := preload("res://Scene/World.tscn")
func _ready() -> void:
	_start_game.pressed.connect(func():
		get_tree().change_scene_to_packed(_game_world))
	_quit.pressed.connect(func():
		get_tree().quit())
	_option.pressed.connect(func():
		Setting.visible = true
		)
