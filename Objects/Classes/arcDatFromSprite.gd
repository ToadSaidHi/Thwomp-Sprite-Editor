class_name arcDatFromSprite extends subBlock

@export var arcDat : CustomSpriteArcData

func getData() -> CustomSpriteArcData:
	arcDat = Globals.currentBuildingSprite.arcData
	return arcDat
