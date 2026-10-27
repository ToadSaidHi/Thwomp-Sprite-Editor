extends RichTextLabel

@export var Catagory : BlockCatagory

func _ready() -> void:
	text = Catagory.Name
	text = ""
	$Button.text = Catagory.Name
	$Button.add_theme_color_override("font_color", Catagory.CatagoryColor)
	add_theme_color_override("default_color", Catagory.CatagoryColor)
