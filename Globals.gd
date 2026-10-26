extends Node

var currentProject : Project

var allSprites : Array[CustomSprite]



func getKamekFolder() -> String:
	return currentProject.Path + "/files/Kamek"

func getSRCFolder() -> String:
	return currentProject.Path + "/files/Kamek/src"

func getIncludeFolder() -> String:
	return currentProject.Path + "/files/Kamek/include"

func getToolsFolder() -> String:
	return currentProject.Path + "/files/Kamek/tools"
	
func addToEndOfFile(filePath : String, text : String):
	var file = FileAccess.open(filePath, FileAccess.READ_WRITE)
	var content = file.get_as_text()
	content = content + "\n" + text
	file.store_string(content)
	file.close()
