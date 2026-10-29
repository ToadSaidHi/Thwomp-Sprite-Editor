extends Area2D


func adopt(newBlock : Node2D):
	for i in newBlock.subBlockNodes:
		i.get_parent().remove_child(i)
	newBlock.get_parent().remove_child(newBlock )
	
func iAmTrashCan(newBlock : Node2D):
	newBlock.get_parent().remove_child(newBlock )
	
func setSubBlock(block, newBlock : Node2D):
	newBlock.get_parent().remove_child(newBlock )
