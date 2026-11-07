extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		print(body.velocity.y)
		body.doubleJumped = false
		body.velocity.y = body.velocity.y * -.8
		body.velocity.x = body.velocity.x * -2.0
		if (abs(body.velocity.y) < 500):
			body.velocity.y -= 500
