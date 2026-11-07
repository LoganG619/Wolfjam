extends CharacterBody2D


@export var max_speed: float 
@export var acceleration: float 
@export var deceleration: float
@export var jumpVelocity = -800.0
var sprinting = false
var doubleJumped = false

@export var jump_velocity: float = -800.0
@export var coyote_time: float = 0.1
var _coyote_timer: float = 0.0

@export var doubleJump_enabled = true

var dashing := false
@export var dash_timer: Timer
@export var dash_speed := 3000.0
var dash_direction := 0.0  # -1, 0, or 1
@export var can_dash := true



func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	else :
		doubleJumped = false
	
	# Jumping
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jumpVelocity
	if Input.is_action_just_pressed("Jump") and !is_on_floor() and !doubleJumped and doubleJump_enabled:
		velocity.y = jumpVelocity
		doubleJumped = true
	
	# Movement
	var direction = Input.get_axis("MoveLeft", "MoveRight")
		
	# Dashing
	if Input.is_action_just_pressed("Dash") and can_dash:
		dashing = true
		can_dash = false
		dash_timer.start()
		dash_direction = sign(direction)  # store last movement direction
		velocity.y = 0  # stop vertical movement during dash
	
	if Input.is_action_pressed("Sprint") and is_on_floor():
		sprinting = true
	else:
		sprinting = false

	if dashing and direction:
		velocity.x = dash_direction * dash_speed
	elif direction:
		if sprinting == true:
			# Accelerate towards max_speed
			max_speed = 1000
			velocity.x = move_toward(velocity.x, direction * max_speed, acceleration * delta)
		else:
			max_speed = 400
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

func _on_dash_timer_timeout():
	dashing = false
	can_dash = true

func die():
	get_tree().reload_current_scene()
