extends Control

func _ready() -> void:
	await $Timer.timeout
	get_tree().change_scene_to_file("res://scenes/title.tscn")
