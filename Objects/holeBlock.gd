class_name HoleBlock extends Block

@export var subBlocks : Array[subBlock]

func convertToCode() -> String:
	var l = codeInsert
	l.replace("%0%", subBlocks.get(0))
	l.replace("%1%", subBlocks.get(1))
	l.replace("%2%", subBlocks.get(2))
	l.replace("%3%", subBlocks.get(3))
	l.replace("%4%", subBlocks.get(4))
	return ""
