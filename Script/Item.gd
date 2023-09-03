extends Panel

func update_ui(score) -> void:
    %rank.text = "第%s"%str(score+1)
    %score.text = "  %s分"%Master._score_list[score]
