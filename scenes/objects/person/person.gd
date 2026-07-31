@tool
extends CharacterBody2D

@export_enum("Hero", "Erio", "NPC1", "NPC2", "NPC3", "NPC4", "NPC5", "NPC6", "NPC7", "NPC8", "NPC9")
var skin := "Hero":
	set(value):
		skin = value
		if is_node_ready():
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
var manual_destination_scene;
var sprite_direction = "DOWN";

func _ready() -> void:
	manual_destination_scene = load("res://scenes/objects/destination/destination.tscn").instantiate();
	get_parent().add_child.call_deferred(manual_destination_scene);
	
	_update_sprite();

func _update_sprite() -> void:
	var use_texture = sprite_map[skin];
	$body_Sprite.texture = load(use_texture);
	return;

func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		return;
	_physics_process_manual_set_destination();
	_move_towards_destination(delta);
	
func _physics_process_manual_set_destination() -> void:
	manual_destination_scene.position = Vector2(position.x, position.y);
	
	if is_controllable:
		var dir = DirectionController.get_direction();
		if dir == Constants.DIRS.LEFT:
			print("Move Left");
			manual_destination_scene.position = Vector2(position.x-160, position.y);
		elif dir == Constants.DIRS.RIGHT:
			print("Move Right");
			manual_destination_scene.position = Vector2(position.x+160, position.y);
		elif dir == Constants.DIRS.UP:
			print("Move Up");
			manual_destination_scene.position = Vector2(position.x, position.y-160);
		elif dir == Constants.DIRS.DOWN:
			print("Move Down");
			manual_destination_scene.position = Vector2(position.x, position.y+160);
		if dir:
			sprite_direction = dir;	

func _move_towards_destination(delta:float) -> void:
	var distance = position.distance_to(manual_destination_scene.position);
	if distance > 3:
		var direction = position.direction_to(manual_destination_scene.position);
		var speed = delta * 18000.0;
		velocity = direction * speed;
		move_and_slide();
	else:
		velocity = Vector2(0,0);
		
func _process(_delta:float) -> void:
	if Engine.is_editor_hint():
		return;
	_proces_AnimationPlayer();

const ANIMATION_STAND = "STAND";
const ANIMATION_WALK  = "WALK";
var animation_map = {
	ANIMATION_STAND: {
		Constants.DIRS.LEFT:  "Stand_Left",
		Constants.DIRS.RIGHT: "Stand_Right",
		Constants.DIRS.UP:    "Stand_Up",
		Constants.DIRS.DOWN:  "Stand_Down",
	},
	ANIMATION_WALK: {
		Constants.DIRS.LEFT:  "Walk_Left",
		Constants.DIRS.RIGHT: "Walk_Right",
		Constants.DIRS.UP:    "Walk_Up",
		Constants.DIRS.DOWN:  "Walk_Down",
	},
};


func _proces_AnimationPlayer() -> void:
	var animation_type = ANIMATION_STAND;
	if velocity != Vector2.ZERO:
		animation_type = ANIMATION_WALK;
	
	var animation_to_play = animation_map[animation_type][sprite_direction];
	$AnimationPlayer.play(animation_to_play);
