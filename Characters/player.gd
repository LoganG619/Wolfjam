extends CharacterBody2D


@export var max_speed: float 
@export var acceleration: float 
@export var deceleration: float
@export var jumpVelocity = -800.0
var doubleJumped = false

@export var jump_velocity: float = -800.0
@export var coyote_time: float = 0.1
var _coyote_timer: float = 0.0


func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	else :
		#doubleJumped = false
		pass

	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jumpVelocity
	if Input.is_action_just_pressed("Jump") and !is_on_floor() and !doubleJumped:
		velocity.y = jumpVelocity
		doubleJumped = true

	var direction = Input.get_axis("MoveLeft", "MoveRight")
	if direction:
		# Accelerate towards max_speed
		velocity.x = move_toward(velocity.x, direction * max_speed, acceleration * delta)
	else:
		# Decelerate to a stop
		velocity.x = move_toward(velocity.x, 0, deceleration * delta)
	
	if is_on_floor():
		_coyote_timer = coyote_time  # Reset when grounded
	else:
		_coyote_timer -= delta
	
	if Input.is_action_just_pressed("Jump") and _coyote_timer > 0.0:
		velocity.y = jumpVelocity
		_coyote_timer = 0.0  # Consume the coyote time
	velocity.y += get_gravity().y * delta
	move_and_slide()



func die():
	get_tree().reload_current_scene()
