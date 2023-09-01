extends CharacterBody2D

@onready var button: TouchScreenButton = %Button
@onready var animation_player: AnimationPlayer = $AnimationPlayer

const DIRECTION:Vector2 = Vector2(0.53169, 0.846939)
const SPEED:int = 1000

func _ready() -> void:
    set_process(false)
    button.pressed.connect(func():
        set_process(true)
        await get_tree().create_timer(0.1).timeout
        set_process(false)
        animation_player.play("idle")
        )

func _process(delta: float) -> void:
    position += DIRECTION * SPEED * delta
    animation_player.play("run")
