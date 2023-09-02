extends Node

const _save_psth:String = "user://game.tres"

var _game_over_scene := preload("res://Scene/GameOver.tscn")
var _total_score:int = 0
var _last_score:int = 0
var UI:CanvasLayer
var camera_node:Camera2D
var _score_list:Array:
    set(value):
        _score_list = value
#        RankList.get_node("RankList").get_node("RankPanel").get_node("ScrollContainer").get_node("Ranker").emit_signal("changed")
    get:
        return _score_list
var gamesaver:GamerSaver = GamerSaver.new()

var levels:Array = [
#    preload("res://Scene/Game/ChangeColor/change_color.tscn"),
    preload("res://Scene/Game/Chrome.tscn"),
    preload("res://Scene/Game/DownAndDown.tscn"),
    preload("res://Scene/Game/FlappyBrid.tscn"),
    preload("res://Scene/Game/PushButton.tscn"),
    preload("res://Scene/Game/Evade/evade.tscn"),
    preload("res://Scene/Game/SwitchParkour/switch_parkour.tscn"),
#    preload("res://Scene/Game/GrabFruit/grab_fruit.tscn")
]
var used_levels:Array = ["SwitchParkour"]

func _ready() -> void:
    Engine.time_scale = 0.8
    process_mode = Node.PROCESS_MODE_ALWAYS

func move_camera_to_node(node:Node) -> void:
    camera_node.zoom = Vector2(1.8, 1.8)
    camera_node.global_position = node.global_position

func get_total_score() -> int:
    return _total_score

func get_last_score() -> int:
    return _last_score

func set_last_score(value:int) -> void:
    _last_score = value
    _score_list.append(_last_score)
    if _score_list.size() > 20:
        _score_list.erase(_score_list.back())
    _score_list.sort()
    _score_list.reverse()
#    RankList.get_node("RankList").get_node("RankPanel").get_node("ScrollContainer").get_node("Ranker").emit_signal("changed")

func score_to_zero() -> void:
    _total_score = 0

func bonus_points(value:int) -> void:
    _total_score += value

func penalty_points(value:int) -> void:
    pass

func game_over() -> void:
    Master.used_levels.clear()
    get_tree().current_scene.game_over.add_child(_game_over_scene.instantiate())

func save_game():
    var game = GamerSaver.new()
    game.mute = Setting.get_node("Setting").check_box.button_pressed
    game.volume = Setting.get_node("Setting").h_slider.value
    game.score = Master._score_list
    ResourceSaver.save(game, _save_psth)
#    LogManager.add_log("已保存游戏")

func load_game():
    var file := FileAccess.open(_save_psth, FileAccess.READ)
    
    if not file:
        return
    
    gamesaver = ResourceLoader.load(_save_psth)
    
    if gamesaver == null:
        LogManager.add_log("读取失败")
        return
    
    Master._score_list = gamesaver.score
    Setting.get_node("Setting").h_slider.value = gamesaver.volume
    Setting.get_node("Setting").check_box.button_pressed = gamesaver.mute
    Setting.get_node("Setting").button.emit_signal("pressed")
#    LogManager.add_log("已读取游戏")

func add_random_level(object:Node) -> void:
    randomize()
    var random_number:int = randi_range(0,(levels.size()-1))
    var level = levels[random_number].instantiate()
    if level.name in used_levels:
        add_random_level(object)
    else:
        object.add_child(level)
        used_levels.append(level.name)
