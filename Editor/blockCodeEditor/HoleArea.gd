extends Area2D

@export var HoleNum = 0

func setSubBlock(blockIn : subBlock, node : Node2D):
	get_parent().get_parent().insertSubBlock(HoleNum, blockIn, node)

func getHoleType() -> BlockType:
	var b : Block = get_parent().get_parent().block
	if b.SubBlockInputs.size() > HoleNum :
		return b.SubBlockInputs.get(HoleNum )
	return null

func _process(delta: float) -> void:
	if(!is_visible_in_tree()):
		monitorable = false
	if(is_visible_in_tree()):
		monitorable = true
	#$"CollisionShape2D".shape.size.x = 
