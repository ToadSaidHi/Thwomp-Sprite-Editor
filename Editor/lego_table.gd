extends Node2D

var dragging = false
var mouseOff
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.BlockFolder = $SubViewportContainer/SubViewport/Blocks

func _process(delta: float) -> void:
	if(dragging):
		$SubViewportContainer/SubViewport/Blocks.global_position = $SubViewportContainer.get_local_mouse_position()  + mouseOff 

func _on_button_button_down() -> void:
	mouseOff = $SubViewportContainer/SubViewport/Blocks.global_position - $SubViewportContainer.get_local_mouse_position()
	dragging = true


func _on_button_button_up() -> void:
	dragging = false
