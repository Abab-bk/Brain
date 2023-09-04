extends Control

@onready var _start_game:TextureButton = %StartGame
@onready var _option:TextureButton = %Option
@onready var _quit:TextureButton = %Quit
@onready var _rank_list:TextureButton = %RankList

var _game_world := preload("res://Scene/World.tscn")

func _ready() -> void:
    Master.load_game()
    _start_game.pressed.connect(func():
        get_tree().change_scene_to_packed(_game_world)
        )
        
    _quit.pressed.connect(func():
        get_tree().quit())
        
    _option.pressed.connect(func():
        Setting.show()
        )
        
    _rank_list.pressed.connect(func():
        RankList.show()
        )
    
    await get_tree().process_frame
    
#    $MarginContainer/Content/MarginContainer.scale = Vector2(2, 2)
    
