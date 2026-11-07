extends Node
var canSwap = true
const black = Color(0,0,0)
const white = Color(1,1,1)
var curColor

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("SwapToBlack") and canSwap == true:
		curColor = black
		canSwap = false
		swapCooldown()
		
	elif Input.is_action_just_pressed("SwapToWhite") and canSwap == true:
		curColor = white
		canSwap = false
		swapCooldown()

func swapCooldown():
	await get_tree().create_timer(1.0).timeout
	canSwap = true
