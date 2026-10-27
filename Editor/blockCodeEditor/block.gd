extends Node2D
@export var block : Block
@export var subBlocks : Array[subBlock]

func _ready() -> void:
	$Title.text = block.Title
	for i in block.SubBlockInputs:
		subBlocks.append(null)
		block.SubBlocks.append(null)
	
	setColor()
	

func setColor():
	$Base.modulate = (block.Type.color)
	#$"Base/Down Point".modulate.r -= block.Type.color.r
	#$"Base/Down Point".modulate.g -= block.Type.color.g
	#$"Base/Down Point".modulate.b -= block.Type.color.b



func _process(delta: float) -> void:
	
	growBlock()

func insertSubBlock(loc : int, block : subBlock):
	block.SubBlocks.insert(loc, block)
	block.SubBlocks.remove_at(loc+1)


func growBlock():
	var e = $Base/Extension
	e.size.x = $Title.size.x
	var x = 0
	for i in subBlocks:
		if(x == 0):
			$Hole1.position.x = e.size.x + e.position.x
			if(block.SubBlocks.get(x) == null):
				$Hole1.size.x = 80
			else:
				$Hole1.size.x = block.SubBlocks.get(x).size();
			e.size.x += $Hole1.size.x + 20
			$Hole1.modulate = block.SubBlockInputs.get(x).color
			$Hole1.show()
		if(x == 1):
			$Hole2.position.x = e.size.x + e.position.x
			if(block.SubBlocks.get(x) == null):
				$Hole2.size.x = 80
			else:
				$Hole2.size.x = block.SubBlocks.get(x).size();
			e.size.x += $Hole2.size.x + 20
			$Hole2.modulate = block.SubBlockInputs.get(x).color
			$Hole2.show()
		if(x == 2):
			$Hole3.position.x = e.size.x + e.position.x
			if(block.SubBlocks.get(x) == null):
				$Hole3.size.x = 80
			else:
				$Hole3.size.x = block.SubBlocks.get(x).size();
			e.size.x += $Hole3.size.x + 20
			$Hole3.modulate = block.SubBlockInputs.get(x).color
			$Hole3.show()
		if(x == 3):
			$Hole4.position.x = e.size.x + e.position.x
			if(block.SubBlocks.get(x) == null):
				$Hole4.size.x = 80
			else:
				$Hole4.size.x = block.SubBlocks.get(x).size();
			e.size.x += $Hole4.size.x + 20
			$Hole4.modulate = block.SubBlockInputs.get(x).color
			$Hole4.show()
		x+=1
	
