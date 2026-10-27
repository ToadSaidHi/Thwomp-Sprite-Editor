extends Area2D

@export var HoleNum = 0

func setSubBlock(block : subBlock):
	get_parent().get_parent().insertSubBlock(HoleNum, subBlock)

func _process(delta: float) -> void:
	if(is_visible_in_tree()):
		monitorable = false
	#$"CollisionShape2D".shape.size.x = 
