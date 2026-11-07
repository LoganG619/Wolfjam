
extends Node2D
@export var color: Color

# Falling settings
@export var fall_distance: float = 600.0
@export var fall_duration: float = 1.0
@export var fall_delay: float = 0.2

var platform_tween: Tween
var has_fallen: bool = false

@onready var platform = $AnimatableBody2D
@onready var fall_trigger = $FallTrigger


func _ready():
	self.self_modulate.a = 0.0
	fall_trigger.body_entered.connect(_on_body_entered)


func _on_body_entered(body):
	if has_fallen:
		return

	if body is CharacterBody2D:
		has_fallen = true

		# Stop the platform's regular movement
		platform_tween.kill()

		# Wait before falling
		await get_tree().create_timer(fall_delay).timeout

		# Make the platform fall
		var fall_tween = create_tween()
		fall_tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
		fall_tween.set_trans(Tween.TRANS_QUAD)
		fall_tween.set_ease(Tween.EASE_IN)

		fall_tween.tween_property(
			platform,
			"position:y",
			platform.position.y + fall_distance,
			fall_duration
		)
		
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
