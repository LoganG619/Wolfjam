extends Sprite2D
const color = Color(0,1,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.curColor == color:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "modulate:a", 1.0, .3)
		tween.play()
	else:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "modulate:a", 0.0, .3)
		tween.play()
