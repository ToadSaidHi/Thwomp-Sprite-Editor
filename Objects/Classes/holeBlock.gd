class_name HoleBlock extends Block

@export var SubBlocks : Array[subBlock]

func convertToCode() -> String:
	var l = codeInsert
	l.replace("%0%", SubBlocks.get(0).convertToCode())
	l.replace("%1%", SubBlocks.get(1).convertToCode())
	l.replace("%2%", SubBlocks.get(2).convertToCode())
	l.replace("%3%", SubBlocks.get(3).convertToCode())
	l.replace("%4%", SubBlocks.get(4).convertToCode())
	return ""
