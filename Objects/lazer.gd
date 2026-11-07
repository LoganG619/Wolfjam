extends Area2D
@export var color: Color

@export var change_interval: float = 2.0

@onready var sprite = $SubViewportContainer/SubViewport/Beam


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var timer = Timer.new()
	add_child(timer)

	timer.wait_time = change_interval
	timer.timeout.connect(change_sprite)
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.curColor == color:
		visible = true
	else:
		visible = false

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("die") and sprite.is_visible_in_tree():
		body.die()
		
		

func change_sprite():
	if sprite.is_visible_in_tree():
		sprite.visible = false
	else:
		sprite.visible = true
