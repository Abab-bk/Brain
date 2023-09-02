extends CharacterBody2D

@export var gravity:int = 3500

const JUMP_VELOCITY = -400.0
const INIT_SCALE:Vector2 = Vector2(4,4)
const FLIP_INIT_SCALE:Vector2 = Vector2(4,-4)
const SIZE:int = 2000
const INIT_POSITION_Y:int = 650

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var button: TouchScreenButton = %Button
@onready var manager: Node = $"../Manager"

var SPEED = 300.0
var anti_gravity:bool = false :
    set(value):
        anti_gravity = value
        if anti_gravity:
            scale = FLIP_INIT_SCALE
        else:
            scale = INIT_SCALE

func _physics_process(delta: float) -> void:
    if position.y < -SIZE or position.y > SIZE:
        position.y = INIT_POSITION_Y
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
        velocity.x = direction * SPEED
    else:
        velocity.x = move_toward(velocity.x, 0, SPEED)
    move_and_slide()
    if anti_gravity:
        up_direction = Vector2.DOWN
    else:
        up_direction = Vector2.UP

func _ready() -> void:
    button.pressed.connect(func():
        if is_on_floor():
            anti_gravity = !anti_gravity
        )

func _on_area_2d_area_entered(area: Area2D) -> void:
    if area.is_in_group("hazardous_materials"):
        manager.emit_signal("game_over",$"..")
