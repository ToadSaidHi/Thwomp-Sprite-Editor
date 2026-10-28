extends Node2D
@export var block : Block
@export var subBlocks : Array[subBlock]

@export var subBlockNodes : Array[Node2D]

var dragging: bool = false
var mouseOff: Vector2 = Vector2.ZERO

func _ready() -> void:
	
	
	$Title.text = block.Title
	for i in block.SubBlockInputs:
		subBlocks.append(null)
		block.SubBlocks.append(null)
		subBlockNodes.append(null)
	
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
	print(subBlockNodes)
	if (subBlockNodes.size() > 0 and subBlockNodes.get(0) != null):
		subBlockNodes.get(0).global_position = $Hole1.global_position
		subBlockNodes.get(0).global_position.y -= 10
	if (subBlockNodes.size() > 1 and subBlockNodes.get(1) != null):
			subBlockNodes.get(1).global_position = $Hole2.global_position
			subBlockNodes.get(1).global_position.y -= 10
	if (subBlockNodes.size() > 2 and subBlockNodes.get(2) != null):
				subBlockNodes.get(2).global_position = $Hole3.global_position
				subBlockNodes.get(2).global_position.y -= 10
	if (subBlockNodes.size() > 3 and subBlockNodes.get(3) != null):
					subBlockNodes.get(3).global_position = $Hole4.global_position
					subBlockNodes.get(3).global_position.y -= 10

func insertSubBlock(loc : int, sblock : subBlock, node : Node2D):
	print (block.SubBlocks.size())
	block.SubBlocks[loc-1] = sblock
	#block.SubBlocks.remove_at(loc+1)
	print (subBlockNodes.size())
	subBlockNodes[loc-1] = node
	#subBlockNodes.remove_at(loc+1)
	
	


func growBlock():
	var e = $Base/Extension
	e.size.x = $Title.size.x
	var x = 0
	for i in subBlocks:
		if(x == 0):
			$Hole1.position.x = e.size.x + e.position.x
			if(subBlockNodes.get(x)== null):
				$Hole1.size.x = 80
			else:
				$Hole1.size.x = subBlockNodes.get(x).sizeT;
			e.size.x += $Hole1.size.x + 20
			$Hole1.modulate = block.SubBlockInputs.get(x).color
			$Hole1.show()
		if(x == 1):
			$Hole2.position.x = e.size.x + e.position.x
			if(subBlockNodes.get(x) == null):
				$Hole2.size.x = 80
			else:
				$Hole2.size.x = subBlockNodes.get(x).sizeT;
			e.size.x += $Hole2.size.x + 20
			$Hole2.modulate = block.SubBlockInputs.get(x).color
			$Hole2.show()
		if(x == 2):
			$Hole3.position.x = e.size.x + e.position.x
			if(subBlockNodes.get(x) == null):
				$Hole3.size.x = 80
			else:
				$Hole3.size.x = subBlockNodes.get(x).sizeT;
			e.size.x += $Hole3.size.x + 20
			$Hole3.modulate = block.SubBlockInputs.get(x).color
			$Hole3.show()
		if(x == 3):
			$Hole4.position.x = e.size.x + e.position.x
			if(subBlockNodes.get(x) == null):
				$Hole4.size.x = 80
			else:
				$Hole4.size.x = subBlockNodes.get(x).sizeT;
			e.size.x += $Hole4.size.x + 20
			$Hole4.modulate = block.SubBlockInputs.get(x).color
			$Hole4.show()
		x+=1
	$Draggable.size.x = e.size.x+120
	
	

			

var mouseInBox = false


func _on_draggable_button_down() -> void:
	mouseOff = global_position - get_global_mouse_position()
	dragging = true


func _on_draggable_button_up() -> void:
	dragging = false
