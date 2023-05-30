extends Control
class_name SlerpTweener2

export var vector : Vector2 = Vector2.LEFT
export var target_vector : Vector2 = Vector2.RIGHT
export var old_vector : Vector2 = Vector2.LEFT
export var progress = 0
export var duration_seconds = 0.2

func _physics_process(delta):
	progress += delta / duration_seconds
	if progress > 0:
		vector = old_vector.slerp(target_vector, progress)
		
		if (is_equal_approx(progress, 1) or progress >= 1):
			vector = target_vector
			old_vector = vector
			progress = -1
			update()
	update()

func interpolate(initial_value, final_value):
	if initial_value:
		vector = initial_value
	old_vector = vector
	target_vector = final_value
	progress = 0

func _input(ev):
	if ev is InputEventMouseButton:
		if ev.pressed:
			interpolate(null, (ev.position - Vector2(64,64)/2).normalized())

func _draw():
	draw_set_transform(
		Vector2(64,64)/2,
		0.0,
		Vector2(8,8)
	)
	
	draw_line(Vector2(0, 0), vector * 2, Color.red, 1)
	#draw_line(Vector2(0, 0), old_vector, Color.white, 1.0)
	#draw_line(Vector2(0, 0), target_vector, Color.blue, 1.0)
