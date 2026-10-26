extends Node

func Build() -> String:
	
	for sp in Globals.allSprites:
		var cpp = headers + "\n\n";
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
		print(cpp)
	
	return ""
	
	
	





var headers : String = "#include <common.h>\n#include <game.h>\n#include <g3dhax.h>\n#include <sfx.h>\n#include <stage.h>\n#include \"boss.h\""
