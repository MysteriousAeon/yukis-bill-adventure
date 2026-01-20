extends Control

func _ready() -> void:
	$"High score".text = 'Best Time: ' + str(Global.score) + ' seconds'
	Global.play_music()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("confirm"):
		get_tree().change_scene_to_file("res://scenes/game.tscn")

	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
