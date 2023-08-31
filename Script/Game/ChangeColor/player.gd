extends CharacterBody2D

const _jump_velocity:float = -500.0

@onready var animation_player:AnimationPlayer = $AnimationPlayer
@onready var manager:Node = $"../Manager"
@onready var texture_rect:TextureRect = $"../Control/TextureRect"
@onready var button:TouchScreenButton = %Button
@onready var pink:Sprite2D = $pink
@onready var yellow:Sprite2D = $yellow
@onready var OK:Timer = $OK

signal double
signal single

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var current_jump:String = "jump"
var can_jump:bool = true
var current_state = "PINK" :
    set(value):
        current_state = value
        changed(value)
var number = 0 :
    set(value):
        number = value
        if number == 1:
            current_jump = "double_jump"
            can_jump = false
            number = 0

var pressed_number:int = 0 :
    set(value):
        if value == 1:
            OK.start()
        pressed_number = value

func _physics_process(delta: float) -> void:
    if velocity.y > 0:
        animation_player.play(current_jump)     
    elif velocity.y < 0:
        animation_player.play("fall")
    else:
        animation_player.play("run")
    if not is_on_floor():
        velocity.y += gravity * delta
    elif is_on_floor():
        number = 0
        can_jump = true
        current_jump = "jump"
    move_and_slide()

func _ready() -> void:
    button.pressed.connect(func():
        pressed_number += 1
        )
    single.connect(func():
        if can_jump:
            number += 1
            velocity.y = _jump_velocity
        )
    double.connect(func():
        change_color()
        )

func _on_area_2d_body_entered(body: Node2D) -> void:
    if body.name == "player":
        manager.emit_signal("game_over",$"..")

func _on_area_2d_area_entered(area: Area2D) -> void:
    if current_state != area.name:
        manager.emit_signal("game_over",$"..")

func _on_ok_timeout() -> void:
    if pressed_number >= 2:
        emit_signal("double")
        pressed_number = 0
    elif pressed_number <= 1:
        emit_signal("single")
        pressed_number = 0

func change_color() -> void:
    if current_state == "YELLOW":
        current_state = "PINK"
    else:
        current_state = "YELLOW"
func changed(value:String) -> void:
    if value == "YELLOW":
        pink.hide()
        yellow.show()
        texture_rect.texture = preload("res://Assets/Texture/Game/Background/Yellow.png")
    else:
        yellow.hide()
        pink.show()
        texture_rect.texture = preload("res://Assets/Texture/Game/Background/Pink.png")
