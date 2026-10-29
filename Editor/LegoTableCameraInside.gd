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
