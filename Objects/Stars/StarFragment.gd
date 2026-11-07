extends Area2D

@export var starType: int
@export var level_id: String
@export var fragment_id: String
@export var fragment_piece: int

func _on_body_entered(body):
	var id = level_id + "_" + fragment_id
	if body.has_method("die") and !Globals.collected_fragments.has(id):
		Globals.collect_fragment(id, starType)
