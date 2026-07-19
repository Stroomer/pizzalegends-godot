extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var loaded_map = load("res://scenes/maps/map_DemoRoom.tscn").instantiate();
	#var loaded_map = load("res://scenes/maps/map_City.tscn").instantiate();
	add_child(loaded_map);
	
	var hero = load("res://scenes/objects/person/person.tscn").instantiate();
	hero.is_controllable = true;
	hero.position = Vector2(100, 100);
	loaded_map.get_node("objects").add_child(hero);
