extends "res://scripts/OverworldMap.gd"

func _init()-> void:
	interactives = {
		"person1": {
			"cutscenes": [
				{
				"requires": [],
				"events": [
					{
						"type": "TEXT_MESSAGE",
						"text": "You found me!",
					}
				]
			}
		]
	}
}
