extends Area2D

@export var starType: int
@export var level_id: String
@export var fragment_id: String

func _ready():
	# Hide fragment if it was previously collected
	var id = level_id + "_" + fragment_id

	if Globals.collected_fragments.has(id):
		visible = false
		monitoring = false


func _on_body_entered(body):
	if body.has_method("die") and visible:

		var id = level_id + "_" + fragment_id

		if Globals.collect_fragment(id, starType):
			visible = false
			monitoring = false
