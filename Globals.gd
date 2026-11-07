extends Node
var canSwap = true
const red = Color(1,0,0)
const blue = Color(0,0,1)
const yellow = Color(1,1,0)
const green = Color(0,1,0)
var curColor

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("SwapToRed") and canSwap == true:
		curColor = red
		canSwap = false
		swapCooldown()
		
	elif Input.is_action_just_pressed("SwapToBlue") and canSwap == true:
		curColor = blue
		canSwap = false
		swapCooldown()
	elif Input.is_action_just_pressed("SwapToGreen") and canSwap == true:
		curColor = green
		canSwap = false
		swapCooldown()
	elif Input.is_action_just_pressed("SwapToYellow") and canSwap == true:
		curColor = yellow
		canSwap = false
		swapCooldown()
	
func swapCooldown():
	await get_tree().create_timer(.3).timeout
	canSwap = true
