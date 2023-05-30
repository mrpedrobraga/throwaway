extends Control

export var vector1 : Vector2 = Vector2.LEFT
export var vector2 : Vector2 = Vector2.RIGHT
export var old_vector1 : Vector2 = Vector2.LEFT
export var interpolation_progress = 0
export var interpolation_duration = 0.2 # In seconds

func _physics_process(delta):
	interpolation_progress += delta / interpolation_duration
	if interpolation_progress > 0:
		vector1 = old_vector1.slerp(vector2, interpolation_progress)
		
		if (is_equal_approx(interpolation_progress, 1) or interpolation_progress >= 1):
			vector1 = vector2
			old_vector1 = vector1
			interpolation_progress = -1
			update()
	update()

func interpolate_vector2():
	vector1 = old_vector1
	interpolation_progress = 0

func _input(ev):
	if ev is InputEventMouseButton:
		if ev.pressed:
			vector2 = (ev.position - Vector2(64,64)/2).normalized()
			interpolate_vector2()

func _draw():
	draw_set_transform(
		Vector2(64,64)/2,
		0.0,
		Vector2(8,8)
	)
	
	draw_line(Vector2(0, 0), vector1 * 2, Color.red, 1)
	#draw_line(Vector2(0, 0), old_vector1, Color.white, 1.0)
	#draw_line(Vector2(0, 0), vector2, Color.blue, 1.0)
