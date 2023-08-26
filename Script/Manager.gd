class_name Manager extends Node

signal score_bonus(value:int)
signal game_over(node:Node)

func _ready() -> void:
    game_over.connect(self._game_over)
    score_bonus.connect(self._score_bonus)

func _score_bonus(value:int) -> void:
    Master.bonus_points(value)
    Master.UI.update_ui()

func _game_over(node:Node) -> void:
    get_tree().paused = true
    
    Master.set_last_score(Master.get_total_score())
    Master.score_to_zero()
    
    Master.move_camera_to_node(node)
    await get_tree().create_timer(2.0).timeout
    
    Master.game_over()
    
    get_tree().paused = false
    
    Master.UI.hide()
