extends Node

var canSwap = true

const red = Color(1,0,0)
const blue = Color(0,0,1)
const yellow = Color(1,1,0)
const green = Color(0,1,0)

var curColor

var greenStarFragments: int = 0
var yellowStarFragments: int = 0
var rainbowStarFragments: int = 0

var unlocked_level: int = 1

# Tracks fragments collected across all levels
var collected_fragments: Dictionary = {}

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

func star_collected(num: int):
	if num == 1:
		greenStarFragments += 1
		if greenStarFragments >= 3:
			unlock_next_level()

	elif num == 2:
		yellowStarFragments += 1
		if yellowStarFragments >= 3:
			unlock_next_level()

	elif num == 3:
		rainbowStarFragments += 1
		if rainbowStarFragments >= 3:
			unlock_next_level()


func unlock_next_level():
	unlocked_level += 1


func collect_fragment(fragment_id: String, num: int) -> bool:

	# Check if this fragment was already collected
	if collected_fragments.has(fragment_id):
		return false

	# Remember that this fragment was collected
	collected_fragments[fragment_id] = true

	# Increase the appropriate global counter
	star_collected(num)

	return true
