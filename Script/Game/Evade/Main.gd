extends Node2D

@onready var manager:Manager = $Manager
@onready var player:CharacterBody2D = $Player

func _ready() -> void:
    $Enemy/Enemy.manager = manager
    $Enemy2/Enemy.manager = manager
    $Enemy/Enemy.player = player
    $Enemy2/Enemy.player = player
