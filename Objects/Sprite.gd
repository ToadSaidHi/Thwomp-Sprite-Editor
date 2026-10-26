class_name CustomSprite extends Resource

@export var Name : String
@export var Order : int

@export var Functs : Array[CustomFunction]
@export var globalVars : Array[CustomVar]

@export var arcData : CustomSpriteArcData

@export var States :Array[customState]

@export var onCreate : CustomFunction
@export var onDraw : CustomFunction
@export var onExecute : CustomFunction
@export var onDelete : CustomFunction
