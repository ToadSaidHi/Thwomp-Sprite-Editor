class_name HoleBlock extends Block

@export var SubBlocks : Array[subBlock]

func convertToCode() -> String:
	var l = codeInsert
	l.replace("%0%", SubBlocks.get(0))
	l.replace("%1%", SubBlocks.get(1))
	l.replace("%2%", SubBlocks.get(2))
	l.replace("%3%", SubBlocks.get(3))
	l.replace("%4%", SubBlocks.get(4))
	return ""
