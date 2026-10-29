extends Node2D


func _on_button_button_up() -> void:
	$LegoTable.summonBlock(load("res://Objects/Blocks/Basic/loadModelAndAnime.tres"))


func _on_button_button2_up() -> void:
	$LegoTable.summonBlock(load("res://Objects/Blocks/getFromSprite/getArcDatFromSprite.tres"))


func _on_button_button3_up() -> void:
	$LegoTable.summonBlock(load("res://Objects/Blocks/Vars/StringSub.tres"))


func _on_button_button4_up() -> void:
	$LegoTable.summonBlock(load("res://Objects/Blocks/Basic/Custom.tres"))
