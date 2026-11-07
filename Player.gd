extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


@onready var player: Node3D =  $"SubViewportContainer/SubViewport/Character proto"
@onready var anim: AnimationPlayer =  $"SubViewportContainer/SubViewport/Character proto".get_node("AnimationPlayer")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		anim.play("Armature|Sprint")
		
		if direction > 0:
			player.rotation.y = PI/2
		else:
			player.rotation.y = -PI/2
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		anim.play("Armature|Idle")
	move_and_slide()
