extends Area2D

@export var starType: int
@export var level_id: String
@export var fragment_id: String
@export var fragment_piece: int

func _on_body_entered(body):
	var id = level_id + "_" + fragment_id
	if body.has_method("die") and !Globals.collected_fragments.has(id):
		Globals.collect_fragment(id, starType)
		if(fragment_piece < 3):
			RealLvlSelect.current_level += 1
			RealLvlSelect._unlock_level(RealLvlSelect.current_level)
			get_tree().call_deferred("change_scene_to_file", "res://Scenes/OfficialLevels/Level " +str(starType) +"-"+str(fragment_piece + 1) + ".tscn")
		elif(starType < 3):
			RealLvlSelect.current_level += 1
			RealLvlSelect._unlock_level(RealLvlSelect.current_level)
			get_tree().call_deferred("change_scene_to_file", "res://Scenes/OfficialLevels/Level " +str(starType + 1) +"-1.tscn")
		else:
			get_tree().call_deferred("change_scene_to_file", "res://Scenes/Lvl Select screen.tscn ")
		#RealLvlSelect._unlock_level(RealLvlSelect.current_level)
		#var level_to_load: String = RealLvlSelect._load_level(RealLvlSelect.current_level)
		#print("hello")
		#get_tree().change_scene_to_file("res://Scenes/OfficialLevels/Level 1- " +str(level_to_load))
