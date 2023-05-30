extends Sprite

export var velocity : Vector2

func _ready():
	position = position.round()
	pass
var t = 0
func _process(delta):
	position += velocity * delta
	
	t += delta
	#velocity = (Vector2(cos(t), sin(t)) * 10)
