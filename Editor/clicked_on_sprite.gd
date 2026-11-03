extends ColorRect

func _process(delta: float) -> void:
	$Title.text = Globals.currentSprite.Name
