
extends Node2D

@export var offset: Vector2 = Vector2(0, -320)
@export var duration: float = 5.0
@export var move_horizontal: bool = false

func _ready():
	start_tween()

func start_tween():
	var tween = get_tree().create_tween()
	tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.set_loops()
	tween.set_parallel(false)

	# Determine movement direction
	var movement = offset

	if move_horizontal:
		movement = Vector2(offset.y, 0)

	tween.tween_property($AnimatableBody2D, "position", movement, duration / 2)
	tween.tween_property($AnimatableBody2D, "position", Vector2.ZERO, duration / 2)
