extends Node2D
@export var block : subBlock
@export var subBlocks : Array[subBlock]

var dragging: bool = false
var mouseOff: Vector2 = Vector2.ZERO

var sizeT = 80

#var mouseHeldDown



func _ready() -> void:
	
	print(block.Type.Name)
	
	$Title.text = block.Title
	for i in block.SubBlockInputs:
		subBlocks.append(null)
		block.SubBlocks.append(null)
	
	setColor()
	

func setColor():
	$Base.modulate = (block.Type.color)




func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("clickDown") and mouseInBox):
		dragging = true
	elif(Input.is_action_just_released("clickDown")):
		dragging = false
	if(dragging):
		global_position = get_global_mouse_position() + mouseOff
	growBlock()

func insertSubBlock(loc : int, block : subBlock):
	block.SubBlocks.insert(loc, block)
	block.SubBlocks.remove_at(loc+1)


func growBlock():
	var e = $Base/Extension
	e.size.x = $Title.size.x + 20
	
	
	$Draggable.size.x = e.size.x
	$InsertArea/CollisionShape2D.shape.size.x = $Draggable.size.x
	sizeT = e.size.x
	



var mouseInBox = false


func _on_draggable_button_down() -> void:
	mouseOff = global_position - get_global_mouse_position()
	dragging = true


func _on_draggable_button_up() -> void:
	dragging = false
	if(newArea != null):
		newArea.setSubBlock(block, self)

var newArea = null

func _on_insert_area_area_exited(area: Area2D) -> void:
	if(area == newArea):
		newArea = null


func _on_insert_area_area_entered(area: Area2D) -> void:
	if area.has_method("getHoleType"):
#		print(area.getHoleType().Name)
		if (area.getHoleType() != null):
			print(area.getHoleType().Name)
		else:
			print("null")
		if(area.getHoleType() == block.Type):
			print(area.getHoleType().Name)
			newArea = area
