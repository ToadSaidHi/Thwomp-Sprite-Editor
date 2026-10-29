extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("scroll up"):
		zoom.x -= -.1
		zoom.y -= -.1
	if Input.is_action_just_pressed("Scroll Down"):
		zoom.x += -.1
		zoom.y += -.1
	$"../wallpaper".scale = Vector2(7,7) / $"../Camera2D".zoom
	$Trash.scale = Vector2(10,10) / ($"../Camera2D".zoom * 2)
	$Trash.position = Vector2(550, 580) / ($"../Camera2D".zoom * 2)
