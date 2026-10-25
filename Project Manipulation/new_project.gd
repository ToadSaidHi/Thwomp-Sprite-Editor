extends Node2D


var moreSpriteIndex = 0;
var moreSpriteLinks = ["https://raw.githubusercontent.com/Developers-Collective/NSMBW-Custom-Sprites/refs/heads/main/Utility/MoreSprites/Kamek/profile.yaml", "https://raw.githubusercontent.com/Developers-Collective/NSMBW-Custom-Sprites/refs/heads/main/Utility/MoreSprites/Kamek/kamek_configs.yaml", "https://raw.githubusercontent.com/Developers-Collective/NSMBW-Custom-Sprites/refs/heads/main/Utility/MoreSprites/Kamek/include/asm_setup.S", "https://raw.githubusercontent.com/Developers-Collective/NSMBW-Custom-Sprites/refs/heads/main/Utility/MoreSprites/Kamek/include/asm_profiles.S", "https://raw.githubusercontent.com/Developers-Collective/NSMBW-Custom-Sprites/refs/heads/main/Utility/MoreSprites/Kamek/include/profile.h", "https://raw.githubusercontent.com/Developers-Collective/NSMBW-Custom-Sprites/refs/heads/main/Utility/MoreSprites/Kamek/include/profileid.h", "https://raw.githubusercontent.com/Developers-Collective/NSMBW-Custom-Sprites/refs/heads/main/Utility/MoreSprites/Kamek/src/profile.S", "https://raw.githubusercontent.com/Developers-Collective/NSMBW-Custom-Sprites/refs/heads/main/Utility/MoreSprites/Kamek/src/profile.cpp"]

func downNewer():
	$NewerGrabber.request("https://github.com/Newer-Team/NewerSMBW/archive/refs/heads/cw.zip");


func _on_okay_button_button_up() -> void:
	Globals.currentProject = Project.new()
	Globals.currentProject.Name = $NewName.text
	Globals.currentProject.Path = ("user://" + $NewName.text)
	$NewName.hide();
	print("Download started")
	downNewer();


func _on_newer_grabber_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	print("Download Finished")
	if response_code == 200:
		var da = DirAccess
		da.make_dir_recursive_absolute(Globals.currentProject.Path )
		var file := FileAccess.open(Globals.currentProject.Path + "/temp.zip", FileAccess.WRITE)
		file.store_buffer(body)
		file.close()
		var reader := ZIPReader.new()
		
		var e := reader.open(Globals.currentProject.Path + "/temp.zip")
		for path in reader.get_files():
			pass
			if(path.ends_with("/")):
				da.make_dir_recursive_absolute(Globals.currentProject.Path + "/" + path)
			else:
				var newOut = Globals.currentProject.Path.path_join(path)
				da.make_dir_recursive_absolute(newOut.get_base_dir())
				var data := reader.read_file(path)
				var out := FileAccess.open(newOut, FileAccess.WRITE)
				out.store_buffer(data)
				out.close()
		reader.close()
		da.remove_absolute(Globals.currentProject.Path + "/temp.zip")
		da.rename_absolute(Globals.currentProject.Path + "/NewerSMBW-cw", Globals.currentProject.Path + "/files")
		patchMoreSprites()
		
	else:
		print(response_code)
		
func patchMoreSprites():
	if(moreSpriteIndex != moreSpriteLinks.size()):
		$MoreSpritesGrabber.request(moreSpriteLinks[moreSpriteIndex])
	else:
		#Globals.addToEndOfFile(Globals.getKamekFolder() + "./kamek_pal.x", "	originalSprites = 0x8030a340;\n	originalProfiles = 0x8076a748;\n	ObjectProfileList = 0x8042a698;\n	spriteFiles = 0x8031ab4c;\n	profileNames = 0x80320b58;\n	searchByProfileId__7fBase_cFUsP7fBase_c = 0x80162E90;\n	create__13dStageActor_cFUsUiP7Point3dP6S16VecUc = 0x80064610;\n	createChild__13dStageActor_cFUsP13dStageActor_cUiP7Point3dP6S16VecUc = 0x80064680;")
		var f = FileAccess.open(Globals.getIncludeFolder() + "/game.h", FileAccess.WRITE)
		f.store_string(FileAccess.open("res://Objects/Patched game.h File.txt", FileAccess.READ).get_as_text())
		f.close()
		f = FileAccess.open(Globals.getToolsFolder() + "/kamek.py", FileAccess.WRITE)
		f.store_string(FileAccess.open("res://Objects/Patched Kamek.py.txt", FileAccess.READ).get_as_text())
		f.close()
		Globals.addToEndOfFile(Globals.getKamekFolder() + "/NewerProject.yaml", "  - processed/profile.yaml")
		
	pass
	

		


func _on_more_sprites_grabber_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if response_code == 200:
		var content = body.get_string_from_utf8()
		moreSpriteIndex += 1
		if(moreSpriteIndex == 1):
			var f = FileAccess.open(Globals.getKamekFolder() + "/profile.yaml", FileAccess.WRITE)
			f.store_string(content)
			f.close()
			patchMoreSprites()
		elif(moreSpriteIndex == 2):
			var f = FileAccess.open(Globals.getKamekFolder() + "/kamek_configs.yaml", FileAccess.WRITE)
			f.store_string(content)
			f.close()
			patchMoreSprites()
		elif(moreSpriteIndex == 3):
			var f = FileAccess.open(Globals.getIncludeFolder() + "/asm_setup.S", FileAccess.WRITE)
			f.store_string(content)
			f.close()
			patchMoreSprites()
		elif(moreSpriteIndex == 4):
			var f = FileAccess.open(Globals.getIncludeFolder() + "/asm_profiles.S", FileAccess.WRITE)
			f.store_string(content)
			f.close()
			patchMoreSprites()
		elif(moreSpriteIndex == 5):
			var f = FileAccess.open(Globals.getIncludeFolder() + "/profile.h", FileAccess.WRITE)
			f.store_string(content)
			f.close()
			patchMoreSprites()
		elif(moreSpriteIndex == 6):
			var f = FileAccess.open(Globals.getIncludeFolder() + "/profileid.h", FileAccess.WRITE)
			f.store_string(content)
			f.close()
			patchMoreSprites()
		elif(moreSpriteIndex == 7):
			var f = FileAccess.open(Globals.getSRCFolder() + "/profile.S", FileAccess.WRITE)
			f.store_string(content)
			f.close()
			patchMoreSprites()
		elif(moreSpriteIndex == 8):
			var f = FileAccess.open(Globals.getSRCFolder() + "/profile.cpp", FileAccess.WRITE)
			f.store_string(content)
			f.close()
			patchMoreSprites()
		
		
		#print(content)
