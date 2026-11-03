extends Node2D

var dragging = false
var mouseOff
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.BlockFolder = $SubViewportContainer/SubViewport/Blocks
	
	var sp : CustomSprite = load("res://Objects/Sprites/Templates/Blank - Model.tres")
	Globals.currentEditingFunction = sp.onExecute
	$SubViewportContainer/SubViewport/Blocks/StartBlock._ready()
	openFunction(Globals.currentEditingFunction)
	

func _process(delta: float) -> void:
	if(dragging):
		$SubViewportContainer/SubViewport/Blocks.global_position = $SubViewportContainer.get_local_mouse_position()  + mouseOff 

func _on_button_button_down() -> void:
	mouseOff = $SubViewportContainer/SubViewport/Blocks.global_position - $SubViewportContainer.get_local_mouse_position()
	dragging = true


func _on_button_button_up() -> void:
	dragging = false

func summonBlock(bl : Block):
	var blockNode : Node2D
	if bl.has_method("IamSubBlock"):
		blockNode = preload("res://Editor/blockCodeEditor/subBlock.tscn").instantiate()
	else:
		blockNode = preload("res://Editor/blockCodeEditor/Block.tscn").instantiate()
	blockNode.block = bl
	Globals.BlockFolder.add_child(blockNode)

func openFunction(cf : CustomFunction):
	var head = $SubViewportContainer/SubViewport/Blocks/StartBlock
	var packedBlock : PackedScene = load("res://Editor/blockCodeEditor/Block.tscn")
	var packedSubBlock : PackedScene = load("res://Editor/blockCodeEditor/subBlock.tscn")
	for i in cf.lines:
		var tail : Node2D = packedBlock.instantiate()
		tail.position = Vector2(0,0)
		tail.block = i.duplicate()
		tail.createSubBlockNodes()
		Globals.BlockFolder.add_child(tail)
		head.adopt(tail)
	#	tail._ready()
		head = tail
		
