extends Node

var currentProject : Project

func getKamekFolder() -> String:
	return currentProject.Path + "/files/Kamek"

func getSRCFolder() -> String:
	return currentProject.Path + "/files/Kamek/src"

func getIncludeFolder() -> String:
	return currentProject.Path + "/files/Kamek/include"
	
func addToEndOfFile(filePath : String, text : String):
	var file = FileAccess.open(filePath, FileAccess.READ)
	var content = file.get_as_text()
	content = content + "\n" + text
	file.store_string(content)
	file.close()
