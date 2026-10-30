extends Node2D

@export var CS : CustomSprite

func _ready() -> void:
	pass

func setup():
	$Button.text = CS.Name + " - " + str(CS.Order + 484)


func _on_button_button_up() -> void:
	Globals.setSelectedSprite = CS
