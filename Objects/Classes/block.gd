class_name Block extends Resource

@export var Title : String;
@export var Description : String;
@export var Type : BlockType;
@export var codeInsert : String;
@export var SubBlockInputs : Array[BlockType]


@export var id : int

func convertToCode() -> String:
	return codeInsert
