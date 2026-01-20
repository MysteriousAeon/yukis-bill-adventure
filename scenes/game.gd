extends Node2D

var bill_scene: PackedScene = preload("res://scenes/bills.tscn")
var score: int
var is_game_over: bool = false

func _on_finish_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Rabbit":
		if score < Global.score:
			Global.score = score
			Global.save_score()
		$VictorySound.play()
		body.set_physics_process(false)
		await $VictorySound.finished
		call_deferred("change_scene")

func change_scene():
	get_tree().change_scene_to_file("res://scenes/title.tscn")

func _on_bill_timer_timeout() -> void:
	var bill = bill_scene.instantiate() as Area2D
	var pos_marker = $BillStartPositions.get_children().pick_random() as Marker2D
	bill.position = pos_marker.position
	$Objects.add_child(bill)
	bill.connect("body_entered", go_to_title)

func go_to_title(body):
	if is_game_over: return
	
	if body.name == "Rabbit":
		is_game_over = true
		$GameOverSound.play()
		body.set_physics_process(false) 
		if body.has_node("RabbitAnimated"):
			body.get_node("RabbitAnimated").stop()
		await $GameOverSound.finished
		call_deferred("change_scene")

func _on_score_timer_timeout() -> void:
	score += 1
	$CanvasLayer/Label.text = 'Time elapsed: ' + str(score)
