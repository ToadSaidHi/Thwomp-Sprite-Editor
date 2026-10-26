class_name loadModel extends Block

@export var sp : CustomSpriteArcData

func convertToCode() -> String:
	var out = "allocator.link(-1, GameHeaps[0], 0, 0x20);\n\tresFile.data = getResource(\"" + sp.arcFile + "\", \"g3d/" + sp.brres + "\");\n"
	out+="\tnw4r::g3d::ResMdl mdl = this->resFile.GetResMdl(\"" + sp.mdl + "\");\n"
	out+="\tbodyModel.setup(mdl, &allocator, 0x224, 1, 0);\n\tSetupTextures_Enemy(&bodyModel, 0);"
	return out
