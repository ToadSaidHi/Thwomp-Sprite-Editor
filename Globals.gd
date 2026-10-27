extends Node

var currentProject : Project

var allSprites : Array[CustomSprite]


#Only to be used during Build()
var currentBuildingSprite : CustomSprite


func getKamekFolder() -> String:
	if(currentProject == null):
		return "user://mainTest/files/Kamek"
	return currentProject.Path + "/files/Kamek"

func getSRCFolder() -> String:
	if(currentProject == null):
		return "user://mainTest/files/Kamek/src"
	return currentProject.Path + "/files/Kamek/src"

func getIncludeFolder() -> String:
	if(currentProject == null):
		return  "user://mainTest/files/Kamek/include"
	return currentProject.Path + "/files/Kamek/include"

func getToolsFolder() -> String:
	if(currentProject == null):
		return "user://mainTest/files/Kamek/tools"
	return currentProject.Path + "/files/Kamek/tools"
	
func addToEndOfFile(filePath : String, text : String):
	var file = FileAccess.open(filePath, FileAccess.READ_WRITE)
	var content = file.get_as_text()
	content = content + "\n" + text
	file.store_string(content)
	file.close()
