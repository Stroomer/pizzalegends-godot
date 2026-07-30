extends Node

signal cutscene_done;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(1.2).timeout;
	emit_signal("cutscene_done");
