extends CharacterBody2D

@onready var player: Node3D =  $"SubViewportContainer/SubViewport/Character proto"
@onready var anim: AnimationPlayer =  $"SubViewportContainer/SubViewport/Character proto".get_node("AnimationPlayer")

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
	if not is_on_floor() and !dashing:
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
	if direction :
		if direction > 0:
			player.rotation.y = PI/2
		else:
			player.rotation.y = -PI/2
		# Dashing
		if Input.is_action_just_pressed("Dash") and can_dash:
			dashing = true
			can_dash = false
			dash_timer.start()
			dash_direction = sign(direction)  # store last movement direction
			velocity.y = 0  # stop vertical movement during dash
	
		if Input.is_action_pressed("Sprint"):
			sprinting = true
		else:
			sprinting = false

		if dashing and direction:
			velocity.x = dash_direction * dash_speed

		elif direction:
			if sprinting == true:
				# Accelerate towards max_speed
				velocity.x = move_toward(velocity.x, direction * max_speed, acceleration * delta)
				anim.play("Armature|Sprint")
			else:
				velocity.x = move_toward(velocity.x, direction * max_speed/3, acceleration * delta)
				anim.play("Armature|Sprint")
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
	else:
		velocity.x = move_toward(velocity.x, 0, max_speed)
		anim.play("Armature|Idle")
	move_and_slide()

func die():
	get_tree().reload_current_scene()

func _on_dash_time_timeout() -> void:
	dashing = false
	can_dash = true
