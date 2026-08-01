extends Node2D

var loaded_map;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("cutscene_receivers");
	
	loaded_map = load("res://scenes/maps/map_DemoRoom.tscn").instantiate();
	#var loaded_map = load("res://scenes/maps/map_City.tscn").instantiate();
	add_child(loaded_map);
	
	var hero = load("res://scenes/objects/person/person.tscn").instantiate();
	hero.name = "HERO";
	hero.is_controllable = true;
	
	var hero_spawn = loaded_map.get_node("hero_spawn");
	hero.position = hero_spawn.position;
	hero_spawn.visible = false;
	loaded_map.get_node("objects").add_child(hero);
	
	var camera = load("res://scenes/camera_2d.tscn").instantiate();
	camera.set_following(hero);
	add_child(camera);
	camera.make_current();
	
	#await get_tree().create_timer(3.2).timeout;
	#start_cutscene([
		#{
			#"type": Constants.EVENTS.TEXT_MESSAGE,
			#"text": "HELLO THERE!"	
		#},
		#{
			#"type": Constants.EVENTS.TEXT_MESSAGE,
			#"text": "This is what i say next..."	
		#}
	#]);

func get_object_by_name(node_name:String)->Node2D:
	return loaded_map.get_node("objects").get_node(node_name);

func start_cutscene(events)-> void:
	var cutscene = load("res://scripts/cutscene.gd").new();	
	cutscene.events = events;
	cutscene.main_ref = self;
	add_child(cutscene);
	
	$CanvasLayer/cutscene_Sprite.visible = true;
	DirectionController.set_locked(true);
	
	await cutscene.cutscene_done;
	
	cutscene.queue_free();
	$CanvasLayer/cutscene_Sprite.visible = false;
	
	await get_tree().create_timer(0.2).timeout;
	DirectionController.set_locked(false);

func cutscene_lookup_requested(body)->void:
	var events = loaded_map.lookup_cutscene(body.name);
	if events:
		start_cutscene(events);
