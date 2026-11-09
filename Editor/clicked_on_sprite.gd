extends ColorRect

func _process(delta: float) -> void:
	if (Globals.currentSprite != null):
		$Title.text = Globals.currentSprite.Name
		show()
		
	
