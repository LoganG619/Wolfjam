extends Sprite2D



func _on_area_2d_bodyEntered(body: Node2D) -> void:
	if body.is_in_group("player"):
		RealLvlSelect.current_level += 1
		RealLvlSelect._unlock_level(RealLvlSelect.current_level)
		var level_to_load: String = RealLvlSelect._load_level(RealLvlSelect.current_level)
		if level_to_load == " ":
			return
		get_tree().call_deferred("change_scene_to_file", level_to_load)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
