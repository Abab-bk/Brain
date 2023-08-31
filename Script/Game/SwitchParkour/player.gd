extends CharacterBody2D

const _size:int = 2000
const _init_position_y:int = 650

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var button: TouchScreenButton = %Button
@onready var manager: Node = $"../Manager"

var _speed = 300.0
var gravity:int = 3500
var anti_gravity:bool = false :
    set(value):
        anti_gravity = value
        if anti_gravity:
            scale = Vector2(4,-4)
        else:
            scale = Vector2(4,4)

func _physics_process(delta: float) -> void:
    if position.y < -_size or position.y > _size:
        position.y = _init_position_y
        manager.emit_signal("game_over",$"..")
    if anti_gravity:
        velocity.y -= gravity * delta
    else:
        velocity.y += gravity * delta
    if is_on_floor():
        animation_player.play("run")
    elif not is_on_floor():
        animation_player.play("fall")
    var direction := 1
    if direction:
        velocity.x = direction * _speed
    move_and_slide()
    if anti_gravity:
        up_direction = Vector2.DOWN
    else:
        up_direction = Vector2.UP

func _input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_accept"):
        if is_on_floor():
            anti_gravity = !anti_gravity

func _ready() -> void:
    button.pressed.connect(func():
        if is_on_floor():
            anti_gravity = !anti_gravity
        )

func _on_area_2d_area_entered(area: Area2D) -> void:
    if area.is_in_group("hazardous_materials"):
        manager.emit_signal("game_over",$"..")
