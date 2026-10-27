class_name loadModel extends HoleBlock

@export var sp : CustomSpriteArcData

@export var withAnime = false

@export var animeName : StringSubBlock

func convertToCode() -> String:
	sp = Globals.currentBuildingSprite.arcData
	var out = "allocator.link(-1, GameHeaps[0], 0, 0x20);\n\tresFile.data = getResource(\"" + sp.arcFile + "\", \"g3d/" + sp.brres + "\");\n"
	out+="\tnw4r::g3d::ResMdl mdl = this->resFile.GetResMdl(\"" + sp.mdl + "\");\n"
	out+="\tbodyModel.setup(mdl, &allocator, 0x224, 1, 0);\n\tSetupTextures_Enemy(&bodyModel, 0);\n"
	if(withAnime):
		
		out+="\tnw4r::g3d::ResAnmChr anmChr = this->resFile.GetResAnmChr(\"<NAME>\");\n\tthis->animationChr.setup(mdl, anmChr, &this->allocator, 0);\n".replace("<NAME>", animeName.content)
	out += "\tallocator.unlink();"
	return out
