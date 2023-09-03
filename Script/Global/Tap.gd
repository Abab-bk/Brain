extends Node

signal logined
signal login_not
signal login_fail
signal log_out

signal anti_timeout
signal anti_age_less
signal anti_pass

var tap

func _init() -> void:
    if OS.get_name() == "Android" && Engine.has_singleton("FlowerTapSDK"):
        tap = Engine.get_singleton("FlowerTapSDK")
    else:
        print("无法初始化TapTapSDK")

func _ready() -> void:
    if tap != null:
        tap.logined.connect(func(): logined.emit())
        tap.loginNot.connect(func(): 
            login_not.emit()
            print("未登录")
            )
        tap.loginFail.connect(func(): login_fail.emit())
        tap.antiAgeLess.connect(func(): anti_age_less.emit())
        tap.antiTimeout.connect(func(): anti_timeout.emit())
        tap.antiPass.connect(func(): anti_pass.emit())

func login_out_() -> void:
    if tap != null:
        tap.logOut()

func is_logined() -> bool:
    if tap != null:
        tap.isLogined()
        await tap.loginOut
        return true
    else:
        return false

func initTapAnti() -> void:
    if tap != null:
        tap.initTapAnti()

func qucikAnti() -> void:
    if tap != null:
        tap.qucikAnti()

func login() -> void:
    print("登录")
    tap.Login()
