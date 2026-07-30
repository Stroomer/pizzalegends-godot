extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var loaded_map = load("res://scenes/maps/map_DemoRoom.tscn").instantiate();
	#var loaded_map = load("res://scenes/maps/map_City.tscn").instantiate();
	add_child(loaded_map);
	
	var hero = load("res://scenes/objects/person/person.tscn").instantiate();
	hero.is_controllable = true;
	
	var hero_spawn = loaded_map.get_node("hero_spawn");
	hero.position = hero_spawn.position;
	hero_spawn.visible = false;
	loaded_map.get_node("objects").add_child(hero);
	
	var camera = load("res://scenes/camera_2d.tscn").instantiate();
	camera.set_following(hero);
	camera.make_current();
	add_child(camera);
	
	await get_tree().create_timer(3.2).timeout;
	start_cutscene([
		{
			"type": Constants.EVENTS.TEXT_MESSAGE,
			"text": "HELLO THERE!"	
		},
		{
			"type": Constants.EVENTS.TEXT_MESSAGE,
			"text": "This is what i say next..."	
		}
	]);

func start_cutscene(events)-> void:
	var cutscene = load("res://scripts/cutscene.gd").new();	
	cutscene.events = events;
	add_child(cutscene);
	
	$CanvasLayer/cutscene_Sprite.visible = true;
	DirectionController.set_locked(true);
	
	await cutscene.cutscene_done;
	
	cutscene.queue_free();
	$CanvasLayer/cutscene_Sprite.visible = false;
	DirectionController.set_locked(false);
