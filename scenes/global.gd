extends Node

var score: int = 60
var save_path = "user://savegame.save"

func _ready() -> void:
	load_score()

func save_score() -> void:
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_32(score)

func load_score() -> void:
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		score = file.get_32()
	else:
		print("No save file found.")

func play_music():
	if not $AudioStreamPlayer.playing:
		$AudioStreamPlayer.play()
