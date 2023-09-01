extends CharacterBody2D

@onready var button: TouchScreenButton = %Button
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer

const DIRECTION:Vector2 = Vector2(-0.576505, 0.817094)
const SPEED:int = 1000

func _ready() -> void:
    timer.start()
    timer.timeout.connect(self.run)
    set_process(false)
    
func _process(delta: float) -> void:
    position += DIRECTION * SPEED * delta
    animation_player.play("run")
    
func run() -> void:
    set_process(true)
    await get_tree().create_timer(0.1).timeout
    set_process(false)
    animation_player.play("idle")
