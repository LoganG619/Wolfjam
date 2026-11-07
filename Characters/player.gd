extends CharacterBody2D


@export var speed = 300.0
@export var jumpVelocity = -400.0
var doubleJumped = false


func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	else :
		doubleJumped = false

	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jumpVelocity
	if Input.is_action_just_pressed("Jump") and !is_on_floor() and !doubleJumped:
		velocity.y = jumpVelocity
		doubleJumped = true

	var direction := Input.get_axis("MoveLeft", "MoveRight")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
