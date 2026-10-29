extends Sprite2D

func adopt(newBlock : Node2D):
	newBlock.get_parent().remove_child(newBlock )
	
func iAmTrashCan(newBlock : Node2D):
	newBlock.get_parent().remove_child(newBlock )
	
func setSubBlock(block, newBlock : Node2D):
	newBlock.get_parent().remove_child(newBlock )
