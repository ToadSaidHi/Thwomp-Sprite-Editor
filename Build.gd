extends Node

func Build() -> String:
	
	for sp in Globals.allSprites:
		var cpp = headers + "\n\n";
		cpp += "const char* ModelLoaderConst [] = { \"<ARCNAME>\", NULL };\n\n".replace("<ARCNAME>", sp.arcData.arcFile)
		cpp += "class " + sp.Name + " : public dEn_c {\npublic:\n\n"
		cpp += "\tint onCreate();\n\tint onExecute();\n\tint onDelete();\n\tint onDraw();\n\n"
		for v in sp.globalVars:
			cpp += "\t" + v.type + " " + v.Name + ";\n"
		for f in sp.Functs:
			var argList = ""
			var x = 1;
			var allArgs = f.Arguments.size()
			for a in f.Arguments:
				argList += a.type + " " + a.Name
				if(x != allArgs):
					argList += ", "
				x+=1
			cpp += "\t" + f.returnType + " " + f.Name + "(" + argList + ");\n"
			
		cpp += "\n\tstatic dActor_c* build();\n\n\tmHeapAllocator_c allocator;\n\tm3d::mdl_c bodyModel;\n\tm3d::anmChr_c animationChr;\n\tnw4r::g3d::ResFile resFile;\n\n"
		
		cpp += "\tUSING_STATES(" + sp.Name + ");\n"
		for s in sp.States:
			cpp += "\tDECLARE_STATE(" + s.Name + ");\n"
		cpp += "};\n\n"
		for s in sp.States:
			cpp += "CREATE_STATE(" + sp.Name + ", " + s.Name + ");\n"
		cpp += "\n"
		
		cpp += "dActor_c* <NAME>::build() {void *buffer = AllocFromGameHeap1(sizeof(<NAME>));return new(buffer) <NAME>;}\n\n".replace("<NAME>", sp.Name)
		
		cpp += "const SpriteData <NAME>SpriteData = \n{ ProfileId::<NAME>, 0, 0, 0, 0, 0x100, 0x100, 0, 0, 0, 0, 0 };\n\n".replace("<NAME>", sp.Name)
		
		cpp += "Profile <NAME>Profile(&<NAME>::build, SpriteId::<NAME>, &<NAME>SpriteData, ProfileId::<NAME>, ProfileId::<NAME>, \"<NAME>\", ModelLoaderConst);\n\n".replace("<NAME>", sp.Name)
		
		for f in sp.Functs:
			cpp += buildFunction(sp, f)
		cpp += buildFunction(sp, sp.onCreate)
		cpp += buildFunction(sp, sp.onExecute)
		cpp += buildFunction(sp, sp.onDraw)
		cpp += buildFunction(sp, sp.onDelete)
		
		for s in sp.States:
			cpp += buildStateFunction(sp, s.Begin, s)
			cpp += buildStateFunction(sp, s.Execute, s)
			cpp += buildStateFunction(sp, s.End, s)
		
		print(cpp)
		saveToFile(sp, cpp)
	updateLists()
	return ""



func buildFunction(s : CustomSprite, f : CustomFunction) -> String:
	var out = ""
	var tabCount = 1;
	var argList = ""
	var x = 1;
	var allArgs = f.Arguments.size()
	for a in f.Arguments:
		argList += a.type + " " + a.Name
		if(x != allArgs):
			argList += ", "
		x+=1
	out +=  f.returnType + " " + s.Name + "::" + f.Name + "(" + argList + "){\n"
	for b in f.lines:
		var y = 0
		while y < tabCount:
			y+= 1
			out += "\t"
		
		out += b.convertToCode() + "\n"
	out += "}\n\n"
	
	return out;


func buildStateFunction(s : CustomSprite, f : CustomFunction, st : customState) -> String:
	var out = ""
	var tabCount = 1;
	var argList = ""
	var x = 1;
	var allArgs = f.Arguments.size()
	for a in f.Arguments:
		argList += a.type + " " + a.Name
		if(x != allArgs):
			argList += ", "
		x+=1
	out +=  f.returnType + " " + s.Name + "::" + f.Name + "_" + st.Name + "(" + argList + "){\n"
	for b in f.lines:
		var y = 0
		while y < tabCount:
			y+= 1
			out += "\t"
		
		out += b.convertToCode() + "\n"
	out += "}\n\n"
	
	return out;


func saveToFile(sp : CustomSprite, cpp : String) -> void:
	var f = FileAccess.open(Globals.getSRCFolder() + "/" + sp.Name + ".cpp", FileAccess.WRITE)
	f.store_string(cpp)
	f.close()
	
	var yaml = "hooks: []\nsource_files:\n- ../src/" + sp.Name + ".cpp"
	
	
	f = FileAccess.open(Globals.getKamekFolder() + "/" + sp.Name + ".yaml", FileAccess.WRITE)
	f.store_string(yaml)
	f.close()
	yamlCollection.append(sp.Name + ".yaml")
	profileCollection.insert(sp.Order, sp.Name)
	pass

func updateLists():
	var f = FileAccess.open(Globals.getKamekFolder() + "/NewerProject.yaml", FileAccess.WRITE)
	var out = FileAccess.open("res://Objects/baseNewerProjext.txt", FileAccess.READ).get_as_text()
	for yaml in yamlCollection:
		out += "\n  - " + yaml
	f.store_string(out)
	f.close()
	f = FileAccess.open(Globals.getIncludeFolder() + "/asm_profiles.S", FileAccess.WRITE)
	out = FileAccess.open("res://Objects/Patched AsmProfiles.S.txt", FileAccess.READ).get_as_text()
	var x = 751
	for pc in profileCollection:
		out += "\n#define " + pc + " PROFILEID_ADJUST_C+PROFILEID_ADJUST_KW+" + str(x)
		x+= 1
	f.store_string(out)
	f.close
	x = 484
	f = FileAccess.open(Globals.getIncludeFolder() + "/profileid.h", FileAccess.WRITE)
	out = FileAccess.open("res://Objects/Patched ProfileID.txt", FileAccess.READ).get_as_text()
	var normID = ""
	for pc in profileCollection:
		normID += "\n\t" + pc + " = " + str(x) + ","
		x+=1
	var Asm = ""
	x = 751
	for pc in profileCollection:
		Asm += "\n\t" + pc  + ","
	f.store_string(out.replace("	//DO NOT REMOVE THIS LINE EITHER", Asm).replace("	//DO NOT REMOVE THIS LINE IF YOU WANT YOUR CODE TO BE UPDATED", normID))
	f.close()
	
	##define Filler PROFILEID_ADJUST_C+PROFILEID_ADJUST_KW+750
	
	


var profileCollection : Array[String]
var yamlCollection : Array[String]
var headers : String = "#include <common.h>\n#include <game.h>\n#include <g3dhax.h>\n#include <sfx.h>\n#include <stage.h>\n#include \"boss.h\""
