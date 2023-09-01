extends Node2D
@onready var player: CharacterBody2D = $grab_fruit/player
@onready var npc: CharacterBody2D = $grab_fruit/npc
@onready var fruit_creater: Node2D = $grab_fruit/fruit_creater
@onready var label: Label = $grab_fruit/fruit_creater/Text

func reload_scene() -> void:
    player.position = Vector2(400,100)
    npc.position = Vector2(1600,100)
    fruit_creater.end_game()
