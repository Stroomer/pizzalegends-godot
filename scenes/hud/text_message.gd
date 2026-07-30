extends Control

var text = "Default Text";
signal on_complete;

func _ready() -> void:
	$Label.text = text; 
	#$Label.visible_characters = 0;
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("on_complete");
		return;
