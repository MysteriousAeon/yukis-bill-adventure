extends CharacterBody2D

# GRID SETTINGS
var tile_size = 16
var move_speed = 0.5
var is_moving = false

func _ready() -> void:
	position = position.snapped(Vector2(tile_size, tile_size))

func _physics_process(_delta: float) -> void:
	if is_moving:
		return

	var input_dir = Vector2.ZERO
	if Input.is_action_pressed("right"): input_dir = Vector2.RIGHT
	elif Input.is_action_pressed("left"): input_dir = Vector2.LEFT
	elif Input.is_action_pressed("down"): input_dir = Vector2.DOWN
	elif Input.is_action_pressed("up"): input_dir = Vector2.UP
	
	if input_dir != Vector2.ZERO:
		move(input_dir)
	else:
		# Idle state
		$RabbitAnimated.stop()
		$RabbitAnimated.frame = 0

func move(dir: Vector2):
	$RayCast2D.target_position = dir * tile_size
	$RayCast2D.force_raycast_update()

	if $RayCast2D.is_colliding():
		return
	is_moving = true
	var target_pos = position + (dir * tile_size)

	if dir.x != 0:
		$RabbitAnimated.play("side")
		$RabbitAnimated.flip_h = dir.x < 0
	else:
		$RabbitAnimated.play("down" if dir.y > 0 else "up")

	var tween = create_tween()
	tween.tween_property(self, "position", target_pos, move_speed).set_trans(Tween.TRANS_SINE)
	tween.finished.connect(_on_move_finished)

func _on_move_finished() -> void:
	is_moving = false
