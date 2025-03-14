extends Control

@onready var generate_button := %Generate
@onready var loadruleset_button := %Ruleset
@onready var wfc := WaveFunctionCollapse.new()

func _on_generate_pressed():
	wfc.get_tiles()
	Logger.infomsg("Generating wave function")

func _on_ruleset_pressed():
	Logger.infomsg("Rulset loaded")
