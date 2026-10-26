extends Node2D

@export var CS : CustomSprite

func _ready() -> void:
	pass

func setup():
	$Button.text = CS.Name + " - " + str(CS.Order + 484)
