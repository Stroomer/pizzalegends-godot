@tool
extends CharacterBody2D

@export_enum("Hero", "Erio", "NPC1", "NPC2", "NPC3", "NPC4", "NPC5", "NPC6", "NPC7", "NPC8", "NPC9") var skin = "NPC1":
	set(new_skin_value):
		skin = new_skin_value;
		_update_sprite();
		
var sprite_map = {
	"Hero": "res://art/people/hero.png",
	"Erio": "res://art/people/erio.png",
	"NPC1": "res://art/people/npc1.png",
	"NPC2": "res://art/people/npc2.png",
	"NPC3": "res://art/people/npc3.png",
	"NPC4": "res://art/people/npc4.png",
	"NPC5": "res://art/people/npc5.png",
	"NPC6": "res://art/people/npc6.png",
	"NPC7": "res://art/people/npc7.png",	
	"NPC8": "res://art/people/npc8.png",	
	"NPC9": "res://art/people/npc9.png"
};

var is_controllable = false;

func _ready() -> void:
	_update_sprite();

func _update_sprite() -> void:
	var use_texture = sprite_map[skin];
	$body_Sprite.texture = load(use_texture);

func _physics_process(delta: float) -> void:
	if is_controllable:
		var dir = DirectionController.get_direction();
		if dir == Constants.DIRS.LEFT:
			print("Move Left");
		elif dir == Constants.DIRS.RIGHT:
			print("Move Right");
		elif dir == Constants.DIRS.UP:
			print("Move Up");
		elif dir == Constants.DIRS.DOWN:
			print("Move Down");
