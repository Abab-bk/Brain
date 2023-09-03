extends Control

@onready var _animation:AnimationPlayer = $ColorRect/AnimationPlayer
@onready var _login_ui:TextureRect = $TextureRect
@onready var _login_btn:TextureButton = $TextureRect/MarginContainer/VBoxContainer/LoginBtn

var _main_scene := preload("res://Scene/Start.tscn")

func _ready() -> void:
    Tap.logined.connect(self._login_ok)
#    Tap.login_not.connect(self._)
    Tap.anti_pass.connect(self._anti_pass)
    _login_btn.pressed.connect(self._login)
    
    _login_ui.hide()
    _animation.play("start")
    await _animation.animation_finished
    _login_ui.show()
    
    # 检查有没有登录，如果登陆了tap发送Logined信号，没有登陆发送LoginNot
    await Tap.is_logined()

func _enter_game() -> void:
    get_tree().change_scene_to_packed(_main_scene)

func _login() -> void:
    Tap.login()

func _login_ok() -> void:
    # 如果已经登陆了，检查防沉迷
    _check_anti()

func _check_anti() -> void:
    # 初始化防沉迷
    Tap.initTapAnti()
    Tap.qucikAnti()

func _anti_pass() -> void:
    _enter_game()

