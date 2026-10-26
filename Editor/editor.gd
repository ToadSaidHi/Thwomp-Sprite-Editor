extends Node2D

@export var testSpriteArray : Array[CustomSprite]

func _ready() -> void:
	Globals.allSprites = testSpriteArray
	loadSpriteTiles()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("scroll up") and $SpriteTiles.position.y < -266:
		$SpriteTiles.position.y += 15
	elif Input.is_action_just_pressed("Scroll Down") :
		$SpriteTiles.position.y -= 15
	
func loadSpriteTiles():
	var st = $SpriteTiles
	var TileFile : PackedScene = load("res://Editor/SpriteTile.tscn")
	var stTile = TileFile.instantiate()
	var yOffset = 0;
	for sprite in Globals.allSprites:
		var newTile : Node2D = stTile.duplicate()
		st.add_child(newTile)
		newTile.position.y += yOffset
		newTile.CS = sprite
		newTile.setup()
		yOffset += 75
